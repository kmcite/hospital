import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/main.dart';
import 'package:hospital/utils/navigator.dart';
export 'package:hospital/utils/extensions.dart';
export 'package:states_rebuilder/states_rebuilder.dart';

void main() async {
  await RM.storageInitializer(HiveStorage());
  runApp(
    HospitalApp(),
  );
}

final darkRepository = true.inj();

bool get dark => darkRepository.state;

typedef UI = ReactiveStatelessWidget;

class HospitalApp extends UI {
  HospitalApp({super.key});
  @override
  Widget build(context) {
    return MaterialApp(
      navigatorKey: navigator.navigatorKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return FTheme(
          data: dark ? FThemes.yellow.dark : FThemes.yellow.light,
          child: child!,
        );
      },
      theme: dark
          ? ThemeData(
              brightness: Brightness.dark,
              progressIndicatorTheme: ProgressIndicatorThemeData(
                year2023: false,
              ),
            )
          : ThemeData(
              brightness: Brightness.light,
              progressIndicatorTheme: ProgressIndicatorThemeData(
                year2023: false,
              ),
            ),
      themeMode: dark ? ThemeMode.dark : ThemeMode.light,
      home: Container(),
    );
  }
}
