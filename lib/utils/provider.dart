import 'package:flutter/material.dart';

typedef T Inject<T>(Ref ref);

Inject<T> inject<T>(Inject<T> injection) => injection;

final class Ref {
  final cache = <Inject, Object>{};
  T call<T extends Object>(Inject<T> inject) =>
      cache.putIfAbsent(inject, () => inject(this)) as T;
}

class RefScope extends InheritedWidget {
  final Ref ref;
  RefScope({
    required super.child,
  }) : ref = Ref();

  @override
  bool updateShouldNotify(_) => false;
}

extension RefExtension on BuildContext {
  T of<T extends Object>(Inject<T> inject) {
    final scope = getInheritedWidgetOfExactType<RefScope>();
    if (scope == null) {
      throw Exception('RefScope is not wrapped around your app.');
    }
    final ref = scope.ref;
    return ref(inject);
  }
}
