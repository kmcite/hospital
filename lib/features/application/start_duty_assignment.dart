import 'dart:async';

import 'package:hospital/features/dashboard/dashboard.dart';
import 'package:hospital/repositories/staff_api.dart';

import '../../models/staff/doctor.dart';
import '../../models/staff/nurse.dart';
import '../../models/staff/receptionist.dart';

void startDutyAssignment() async {
  print('[DutyAssignementLoop]');
  while (true) {
    await Future.delayed(Duration(seconds: 1));
    for (final staff in staffs()) {
      if (staff is Nurse && staffRepository.currentNurse() == null) {
        staffRepository.currentNurse.set(staff..isWorking.set(true));
        staffRepository.put(staff);
        Timer(
          Duration(seconds: staff.currentDuty().toInt()),
          () {
            staffRepository.currentNurse.set(null);
            staffRepository.put(staff..isWorking.set(false));
          },
        );
      }
      if (staff is Doctor && staffRepository.currentDoctor() == null) {
        staffRepository.currentDoctor.set(staff..isWorking.set(true));
        staffRepository.put(staff);

        Timer(
          Duration(seconds: staff.currentDuty().toInt()),
          () {
            staffRepository.currentDoctor.set(null);
            staffRepository.put(staff..isWorking.set(false));
          },
        );
      }
      if (staff is Receptionist &&
          staffRepository.currentReceptionist() == null) {
        staffRepository.currentReceptionist.set(staff..isWorking.set(true));
        staffRepository.put(staff);
        Timer(
          Duration(seconds: (staff.currentDuty() * 10).toInt()),
          () {
            staffRepository.currentReceptionist.set(null);
            staffRepository.put(staff..isWorking.set(false));
          },
        );
      }
    }
  }
}
