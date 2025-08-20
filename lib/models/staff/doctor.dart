import 'dart:async';

import '../../main.dart';
import 'staff.dart';

class Doctor extends Staff {
  void startTreatingPatient() {
    isActive.set(true);
    Timer(
      Duration(seconds: treatmentTime()),
      () {
        isActive.set(false);
        count.value++;
      },
    );
  }

  final treatmentTime = signal(10);
}
