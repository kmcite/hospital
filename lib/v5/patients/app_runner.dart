import 'dart:async';
import 'package:hospital/main.dart';
import 'package:hospital/v5/patients/patient.dart';

final appRunner = AppRunner();

class AppRunner {
  void initState() {
    patient_generator();
    auto_treatment();
  }

  Timer? patient_generator_timer;
  Future<void> patient_generator() async {
    while (true) {
      final duration = Duration(
        seconds: faker.randomGenerator.integer(20, min: 5),
      );
      put_patient(Patient());
      await Future.delayed(duration);
    }
  }

  Timer? auto_treatment_timer;
  void auto_treatment() {
    auto_treatment_timer = Timer.periodic(
      Duration(seconds: 10),
      (timer) {
        if (patients().isNotEmpty) {
          manage_patient(patients().last);
        }
      },
    );
  }

  void dispose() {
    patient_generator_timer?.cancel();
    auto_treatment_timer?.cancel();
  }
}
