import 'package:hospital/main.dart';
import 'package:hospital/models/staff/staff.dart';

import '../models/staff/doctor.dart';
import '../models/staff/nurse.dart';
import '../models/staff/receptionist.dart';

final staffRepository = StaffRepository();

class StaffRepository {
  StaffRepository() {
    generate();
    generate();
  }
  void generate() async {
    final doctor = Doctor();
    staffs[doctor.id] = doctor;
    final nurse = Nurse();
    staffs[nurse.id] = nurse;
    final receptionist = Receptionist();
    staffs[receptionist.id] = receptionist;
  }

  final staffs = mapSignal(<String, Staff>{});

  void put(Staff staff) => staffs[staff.id] = staff;

  late final doctors = computed(
    () => staffs.values.whereType<Doctor>(),
  );
  late final nurses = computed(() => staffs.values.whereType<Nurse>());
  late final receptionists = computed(
    () => staffs.values.whereType<Receptionist>(),
  );

  final currentReceptionist = signal<Receptionist?>(null);
  final currentDoctor = signal<Doctor?>(null);
  final currentNurse = signal<Nurse?>(null);
}
