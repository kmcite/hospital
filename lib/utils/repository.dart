import 'dart:async';

import 'package:flutter/foundation.dart' show VoidCallback, ValueSetter;

abstract class Repository<R> {
  Repository() {
    stream.listen((value) => this.value = value);
    emit(initialValue);
  }
  final controller = StreamController<R>.broadcast();
  late R value;
  R get initialValue;

  Stream<R> get stream => controller.stream;

  void emit(R value) => controller.add(value);

  VoidCallback call(ValueSetter<R> valueSetter) {
    return stream.listen(valueSetter).cancel;
  }
}
