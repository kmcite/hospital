import 'package:hospital/main.dart';

import '../models/staff/doctor.dart';
import '../models/staff/nurse.dart';
import '../models/staff/receptionist.dart';

final staffRepository = StaffRepository();

class StaffRepository {
  final currentReceptionist = signal<Receptionist?>(null);
  final currentDoctor = signal<Doctor?>(null);
  final currentNurse = signal<Nurse?>(null);

  final receptionists = mapSignal(<String, Receptionist>{});
  final doctors = mapSignal(<String, Doctor>{});
  final nurses = mapSignal(<String, Nurse>{});
}
