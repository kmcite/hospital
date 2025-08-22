import 'dart:async';

import 'package:hospital/main.dart';

import 'staff/receptionist.dart';
import 'staff/staff.dart';

class Patient {
  Patient() {
    Timer.periodic(
      Duration(seconds: 1),
      (_) {
        if (receptionist != null) {
          isSatisfied.set(true);
          _.cancel();
          return;
        }
        if (satisfactionTime.value > 0) {
          satisfactionTime.value--;
        } else {
          isSatisfied.value = false;
        }
      },
    );
  }
  String id = faker.guid.guid();
  String name = faker.person.name();
  String complaints = faker.lorem.sentence();
  Staff? manager;
  Receptionist? receptionist;
  final satisfactionTime = signal(10);
  late final satisfactionProgress = computed(() => satisfactionTime() / 10);
  final isSatisfied = signal(true);
  bool get isManaged => manager != null;
}
