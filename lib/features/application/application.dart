import 'dart:async';

import 'package:forui/forui.dart';
import 'package:hospital/main.dart';
import 'package:hospital/utils/navigator.dart';
import 'package:hospital/features/dashboard/dashboard.dart';
import 'package:hux/hux.dart';

// Add imports for core loop functions
import 'start_duty_assignment.dart';
import 'start_treatment_loop.dart';
import 'start_issuing_chits.dart';
import 'auto_treatment.dart';
import 'start_giving_out_salaries.dart';

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
    startDutyAssignment();
    startTreatmentLoop();
    startIssuingChits();
    autoTreatment();
    startGivingOutSalaries();
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
      builder: (context, child) => FTheme(
        data: dark() ? FThemes.yellow.dark : FThemes.yellow.light,
        child: child!,
      ),
      themeMode: dark() ? ThemeMode.dark : ThemeMode.light,
      home: Dashboard(),
    );
  }
}
