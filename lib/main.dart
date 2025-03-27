import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/domain/api/settings_repository.dart';
import 'package:hospital/domain/models/settings.dart';
import 'package:hospital/ui/hospital/hospital_page.dart';
import 'package:hospital/navigator.dart';
import 'main.dart';
export 'utils/api.dart';
export 'package:states_rebuilder/scr/state_management/extensions/type_extensions.dart';

void main() {
  runApp(
    HospitalApp(),
    //  openStore: openStore
  );
}

mixin HospitalBloc {
  GlobalKey<NavigatorState> get navigatorKey => navigator.navigatorKey;
  bool get dark => settings().dark;
  Modifier<Settings> get settings => settingsRepository;
}

class HospitalApp extends UI with HospitalBloc {
  const HospitalApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
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
