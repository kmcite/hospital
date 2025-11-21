import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hospital/utils/model.dart';

class CollectionSubscription<T> {
  final StreamSubscription<List<T>> subscription;
  final void Function() disposer;
  const CollectionSubscription(
    this.subscription,
    this.disposer,
  );
  Future<void> dispose() async {
    await subscription.cancel();
    disposer();
  }
}

abstract class Collection<T extends Model> with ChangeNotifier {
  int get length;
  Stream<List<T>> watch();
  List<T> getAll();
  void put(T entity);
  void remove(int id);
  void removeAll();
  T? get(int id);
  bool contains(int id);
  CollectionSubscription<T> subscribe(void Function() listener) {
    void disposer() => removeListener(listener);
    addListener(listener);
    final subscription = watch().listen((_) => listener());
    return CollectionSubscription(subscription, disposer);
  }
}

class Hook<T> with ChangeNotifier {
  Hook(this.value);
  T value;
  void set(T newValue) {
    value = newValue;
    notifyListeners();
  }
}

(T, void Function(T)) use<T>(T value) {
  final hook = Hook(value);
  return (value, (T newValue) => hook.set(newValue));
}
