import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart' as api;

typedef UI = api.ReactiveStatelessWidget;
typedef Modifier<T> = T Function([T?]);
Injected<T> signal<T>(T value) => Injected(value);
Injected<T> stream<T>(Stream<T> stream) => Injected.stream(stream);

class Injected<T> {
  late final api.Injected<T> valueRM;
  Injected(T value) {
    valueRM = api.RM.inject(() => value);
  }
  T call([T? value]) {
    if (value != null) {
      valueRM
        ..state = value
        ..notify();
    }
    return valueRM.state;
  }

  Injected.stream(Stream<T> stream) {
    valueRM = api.RM.injectStream(() => stream);
  }
  bool get loading => valueRM.isWaiting;
}

extension DynamicX on dynamic {
  Widget text() => Text(toString());
}

extension PaddingX on Widget {
  Widget pad() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: this,
    );
  }

  Widget center() {
    return Center(child: this);
  }
}
