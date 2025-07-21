import 'package:hospital/utils/navigator.dart';
import 'package:hospital/v5/config/config.dart';
import 'package:hospital/v5/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:hospital/v5/patients/app_runner.dart';

export 'package:forui/forui.dart';
import 'main.dart';
export 'package:faker/faker.dart';
export 'package:hospital/utils/watcher.dart';
export 'package:hospital/utils/extensions.dart';
export 'package:signals/signals_flutter.dart';

void main() async {
  runApp(
    HospitalApp(),
  );
}

class HospitalApp extends UI {
  @override
  void initState() {
    super.initState();
    appRunner.initState();
  }

  @override
  void dispose() {
    appRunner.dispose();
    super.dispose();
  }

  HospitalApp({super.key});
  @override
  Widget build(context) {
    return MaterialApp(
      navigatorKey: navigator.navigatorKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return FTheme(
          data: dark() ? FThemes.violet.dark : FThemes.yellow.light,
          child: child!,
        );
      },
      theme: dark()
          ? ThemeData(
              brightness: Brightness.dark,
              progressIndicatorTheme: ProgressIndicatorThemeData(
                year2023: false,
              ),
              fontFamily: 'Monaspace Argon',
            )
          : ThemeData(
              brightness: Brightness.light,
              progressIndicatorTheme: ProgressIndicatorThemeData(
                year2023: false,
              ),
              fontFamily: 'Monaspace Argon',
            ),
      themeMode: dark() ? ThemeMode.dark : ThemeMode.light,
      home: Dashboard(),
    );
  }
}
