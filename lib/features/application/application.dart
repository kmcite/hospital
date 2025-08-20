import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:hospital/features/application/start_patient_generation.dart';
import 'package:hospital/main.dart';
import 'package:hospital/utils/navigator.dart';
import 'package:hospital/features/dashboard/dashboard.dart';
import 'package:hux/hux.dart';

import '../../repositories/settings_api.dart';

final dark = computed(() => settingsRepository.dark());
final subscriptions = <StreamSubscription>[];

void subscribe(StreamSubscription subscription) {
  subscriptions.add(subscription);
}

void cancelSubscriptions() {
  for (final subscription in subscriptions) {
    subscription.cancel();
  }
  subscriptions.clear();
}

class HospitalApp extends UI {
  @override
  void initState() {
    // startStaffGeneration();
    // startPatientGeneration();
    // startDutyAssignment();
    // startTreatmentLoop();
    // startIssuingChits();
    // autoTreatment();
    // startGivingOutSalaries();
  }

  @override
  void dispose() {
    cancelSubscriptions();
  }

  const HospitalApp({super.key});
  @override
  Widget build(context) {
    return MaterialApp(
      navigatorKey: navigator.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: dark()
          ? HuxTheme.darkTheme.copyWith(
              brightness: Brightness.dark,
              progressIndicatorTheme: ProgressIndicatorThemeData(
                year2023: false,
              ),
              sliderTheme: SliderThemeData(
                year2023: false,
              ),
            )
          : HuxTheme.lightTheme.copyWith(
              brightness: Brightness.light,
              progressIndicatorTheme: ProgressIndicatorThemeData(
                year2023: false,
              ),
              sliderTheme: SliderThemeData(
                year2023: false,
              ),
            ),
      themeMode: dark() ? ThemeMode.dark : ThemeMode.light,
      home: Dashboard(),
    );
  }
}
