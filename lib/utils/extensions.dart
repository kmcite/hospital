import 'dart:developer' as dev show log;

import 'package:flutter/material.dart';

final debug = true;
// final information = AnyList<String>();

void print(any) {
  if (debug) {
    dev.log(
      any.toString(),
    );
  }
}

extension AnyX on Widget {
  Widget pad({
    double right = 8,
    double left = 8,
    double top = 8,
    double bottom = 8,
    double all = 8,
  }) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: this,
    );
  }
}

extension TextX on dynamic {
  Text text({TextStyle? style}) => Text(
        this.toString(),
        style: style,
      );
}
