import 'package:flutter/foundation.dart';
import 'package:hospital/main.dart';

class Staff {
  String id = faker.guid.guid();
  String name = faker.person.name();
  double salary = faker.randomGenerator.decimal(scale: 500, min: 50);
  final isActive = signal(false);
  final count = signal(0);
  final isHired = signal(false);
  void hire() => isHired.set(true);
  void fire() => isHired.set(false);

  Staff() {
    staff();
  }

  late final currentDuty = signal<double>(1.0);

  final isExhausted = signal(false);
  final isResting = signal(false);
  final isWorking = signal(false);

  final role = '';

  final String? imageUrl = null;
  late String email = '${id.substring(0, 8)}@hospital.com';

  final String phone = faker.phoneNumber.us();
  final String department = faker.conference.name();

  final DateTime joinDate = DateTime.now();

  final String? specialization = null;

  var qualifications = <String>[];

  void staff() async {
    while (true) {
      await Future.delayed(Duration(milliseconds: 500));
      if (!isExhausted() && !isResting()) {
        // Working - decrease energy
        if (currentDuty() > 0 && isWorking()) {
          currentDuty.set(currentDuty() - .05);
        }

        // Become exhausted when energy depletes
        if (currentDuty() <= 0) {
          isExhausted.set(true);
          isResting.set(true);
        }
      } else if (isResting()) {
        // Resting - slowly recover energy
        if (currentDuty() < 1.0) {
          currentDuty.set(clampDouble(currentDuty() + 0.03, 0, 1));
        }

        // Can work again after full recovery
        if (currentDuty() >= 1.0) {
          isExhausted.set(false);
          isResting.set(false);
        }
      }
    }
  }
}
