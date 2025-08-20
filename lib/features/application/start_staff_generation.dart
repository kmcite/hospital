import 'package:hospital/features/application/application.dart';
import 'package:hospital/models/staff/doctor.dart';
import 'package:hospital/models/staff/nurse.dart';
import 'package:hospital/models/staff/receptionist.dart';
import 'package:hospital/repositories/staff_generator.dart';

import '../../repositories/staff_api.dart';

void startStaffGeneration() {
  subscribe(
    staffGenerator().listen(
      (staff) {
        staff..hire();
        if (staffRepository.nurses.length < 2 && staff is Nurse) {
          staffRepository.nurses[staff.id] = staff;
        } else if (staff is Doctor && staffRepository.doctors.length < 2) {
          staffRepository.doctors[staff.id] = staff;
        } else if (staff is Receptionist &&
            staffRepository.receptionists.length < 2) {
          staffRepository.receptionists[staff.id] = staff;
        }
      },
    ),
  );
}
