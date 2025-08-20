import 'dart:async';

import 'package:hospital/features/dashboard/dashboard.dart';
import 'package:hospital/repositories/staff_api.dart';

import '../../models/staff/doctor.dart';
import '../../models/staff/nurse.dart';
import '../../models/staff/receptionist.dart';
import '../../models/staff/staff.dart';

void startDutyAssignment() async {
  print('[DutyAssignementLoop]');
  while (true) {
    await Future.delayed(Duration(seconds: 1));
    List<Staff> updates = [];
    for (final staff in staffs()) {
      if (staff is Nurse && staffRepository.currentNurse() == null) {
        staffRepository.currentNurse.set(staff);
        Timer(
          Duration(seconds: staff.dutyAmount()),
          () => staffRepository.currentNurse.set(null),
        );
      }
      if (staff is Doctor && staffRepository.currentDoctor() == null) {
        staffRepository.currentDoctor.set(staff);
        Timer(
          Duration(seconds: staff.dutyAmount()),
          () => staffRepository.currentDoctor.set(null),
        );
      }
      if (staff is Receptionist &&
          staffRepository.currentReceptionist() == null) {
        staffRepository.currentReceptionist.set(staff);
        Timer(
          Duration(seconds: staff.dutyAmount()),
          () {
            staffRepository.currentReceptionist.set(null);
          },
        );
      }
      updates.add(staff);
    }
    for (final staff in updates) {
      if (staff is Nurse) {
        staffRepository.nurses[staff.id] = staff;
      }
      if (staff is Doctor) {
        staffRepository.doctors[staff.id] = staff;
      }
      if (staff is Receptionist) {
        staffRepository.receptionists[staff.id] = staff;
      }
    }
  }
}
