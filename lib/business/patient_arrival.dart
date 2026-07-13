import 'dart:async';

import 'package:flutter/services.dart' show SystemNavigator;
import 'package:hospital/apis/events.dart';
import 'package:hospital/utils/messaging.dart';
import 'package:hospital/utils/provider.dart';
import 'package:signals/signals.dart';

final patientArrivalProvider = inject(
  (ref) => PatientArrivalProvider(),
);

sealed class Clicks {}

class IncrementClicks extends Clicks {}

class PatientArrivalProvider {
  final running = signal(false);

  PatientArrivalProvider() {
    init();
    listen<StartGame>((e) {
      running.value = true;
    });
    listen<PauseGame>((e) {
      running.value = false;
    });
    listen<QuitGame>((e) async {
      running.value = false;
      await SystemNavigator.pop(animated: true);
    });
  }
  FutureOr<void> init() async {
    while (true) {
      if (running.value) {
        send(PatientArrivedAtHospital());
      } else {}
      await Future.delayed(Duration(seconds: 5));
    }
  }

  final clicks = signal(0);
}
