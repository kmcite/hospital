import 'dart:async';
import 'package:hospital/main.dart';

import '../models/staff/doctor.dart';
import '../models/staff/nurse.dart';
import '../models/staff/receptionist.dart';
import '../models/staff/staff.dart';

Stream<Staff> staffGenerator() => Stream.periodic(
      Duration(seconds: 1),
      (_) {
        return faker.randomGenerator.element(
          [
            Receptionist(),
            Doctor(),
            Nurse(),
          ],
        );
      },
    );
