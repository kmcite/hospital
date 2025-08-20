import 'consultation.dart';
import 'patient.dart';
import 'staff/doctor.dart';
import 'staff/nurse.dart';
import 'staff/receptionist.dart';

class Reception {
  String mr;
  Consultation? consultation;
  bool get isConsulted => consultation != null;
  String notes = "";
  Nurse? nurse;
  Doctor? doctor;
  double fees;
  Patient patient;
  Receptionist receptionist;
  Reception({
    required this.patient,
    this.fees = 50,
    required this.receptionist,
  }) : mr = patient.id;
}
