import 'dart:async';

import 'package:hospital/utils/collection.dart';
import 'package:hospital/utils/model.dart';

class InMemoryCollection<T extends Model> extends Collection<T> {
  final items = <int, T>{};
  final controller = StreamController<List<T>>.broadcast();

  @override
  int get length => items.length;

  @override
  void put(T item) {
    items[item.id] = item;
    controller.add(getAll());
  }

  @override
  T? get(int id) {
    return items[id];
  }

  @override
  bool contains(int id) {
    return items.containsKey(id);
  }

  @override
  void remove(int id) {
    items.remove(id);
    controller.add(getAll());
  }

  @override
  void removeAll() {
    items.clear();
    controller.add([]);
  }

  @override
  List<T> getAll() {
    return items.values.toList();
  }

  @override
  Stream<List<T>> watch() async* {
    yield getAll();
    yield* controller.stream;
  }
}
