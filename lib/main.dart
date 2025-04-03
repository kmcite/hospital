import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/domain/api/settings_repository.dart';
import 'package:hospital/domain/models/settings.dart';
import 'package:hospital/main.dart';
import 'package:hospital/objectbox.g.dart';
import 'package:hospital/ui/hospital/hospital_page.dart';
import 'package:hospital/navigator.dart';
export 'package:manager/manager.dart';
export 'utils/api.dart';
export 'package:states_rebuilder/states_rebuilder.dart';

void main() => manager(
      HospitalApp(),
      openStore: openStore,
    );

mixin HospitalBloc {
  bool get dark => settings.state.dark;
  Injected<Settings> get settings => settingsRepository;
}

class HospitalApp extends UI with HospitalBloc {
  const HospitalApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      navigatorKey: navigator.navigatorKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return FTheme(
          data: dark ? FThemes.yellow.dark : FThemes.blue.light,
          child: child!,
        );
      },
      theme: dark ? ThemeData.dark() : ThemeData.light(),
      themeMode: dark ? ThemeMode.dark : ThemeMode.light,
      home: const HospitalPage(),
    );
  }
}
