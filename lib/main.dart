// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/domain/repositories/settings_repository.dart';
import 'package:hospital/ui/admitted/admitted_patients_page.dart';
import 'package:hospital/ui/doctors/doctors_page.dart';
import 'package:hospital/main.dart';
import 'package:hospital/objectbox.g.dart';
import 'package:hospital/navigator.dart';
import 'package:hospital/ui/hospital/hospital_page.dart';
import 'package:hospital/ui/hospital/resource_management_page.dart';
import 'package:hospital/ui/hospital/total_patients_page.dart';
import 'package:hospital/ui/hospital/admin_page.dart';
import 'package:hospital/ui/waiting/waiting_patients_page.dart';
import 'package:manager/dark/dark_repository.dart';
export 'package:manager/manager.dart';
export 'package:states_rebuilder/states_rebuilder.dart';

void main() async {
  manager(
    HospitalApp(),
    openStore: openStore,
  );
}

bool get dark => darkRepository.state;

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
      home: PageView(
        controller: indexRM.pageController,
        children: [
          ResourceManagementPage(),
          UserPage(),
          TotalPatientsPage(),
          WaitingPatientsPage(),
          HospitalPage(),
          AdmittedPatientsPage(),
          DoctorsPage(),
        ],
      ),
    );
  }
}
