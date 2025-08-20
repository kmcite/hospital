import 'dart:async';

import 'package:hospital/main.dart';

import 'staff.dart';

class Nurse extends Staff {
  final isWorking = signal(false);

  void work(int seconds) {
    isWorking.set(true);
    Timer(
      Duration(seconds: seconds),
      () {
        count.value++;
        dutyAmount.value -= seconds;

        isWorking.set(false);
      },
    );
  }
}
