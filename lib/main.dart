import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/api/settings_repository.dart';
import 'package:hospital/main.dart';
import 'package:hospital/objectbox.g.dart';
import 'package:hospital/navigator.dart';
import 'package:hospital/ui/hospital/hospital_page.dart';
import 'package:hospital/ui/hospital/user_page.dart';
import 'package:manager/dark/dark_repository.dart';
export 'package:manager/manager.dart';
export 'package:states_rebuilder/states_rebuilder.dart';

void main() async {
  manager(
    HospitalApp(),
    openStore: openStore,
  );
}

bool get _dark => darkRepository.dark;

class HospitalApp extends UI {
  HospitalApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      navigatorKey: navigator.navigatorKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return FTheme(
          data: _dark ? FThemes.yellow.dark : FThemes.yellow.light,
          child: child!,
        );
      },
      theme: _dark ? ThemeData.dark() : ThemeData.light(),
      themeMode: _dark ? ThemeMode.dark : ThemeMode.light,
      home: PageView(
        controller: pageController,
        children: [
          UserPage(),
          HospitalPage(),
        ],
      ),
    );
  }
}
