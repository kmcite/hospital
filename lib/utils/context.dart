import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension Context on BuildContext {
  T of<T>() {
    try {
      return watch<T>();
    } catch (e) {
      return read<T>();
    }
  }
}
