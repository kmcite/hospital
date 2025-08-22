import 'package:hospital/features/application/application.dart';
export 'package:flutter/material.dart';

import 'main.dart';

export 'package:faker/faker.dart' hide Image, Color;
export 'package:hospital/utils/watcher.dart';
export 'package:hospital/utils/extensions.dart';
export 'package:signals_flutter/signals_flutter.dart';
export 'package:hospital/main.dart' show print;

void main() async {
  SignalsObserver.instance = null;
  runApp(HospitalApp());
}
