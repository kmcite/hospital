import 'package:hospital/domain/models/prescription.dart';
import 'package:hospital/domain/models/staff.dart';
// import 'package:hospital/utils/crud_collection.dart';
import 'package:hospital/utils/in_memory_collection.dart';
import 'package:hospital/utils/model.dart';
import 'package:hospital/domain/models/patient.dart';

import 'symptom.dart';
// import 'package:objectbox/objectbox.dart';

typedef MedicalRecordId = int;

class MedicalRecords extends InMemoryCollection<MedicalRecordModel> {}

// @Entity()
class MedicalRecordModel extends Model {
  // @Id()
  @override
  MedicalRecordId id = 0;
  // @Property(type: PropertyType.date)
  DateTime date = DateTime.now();
  String diagnosis = '';

  /// RELATIONSHIPS
  var symptoms = <SymptomId>[];
  var prescriptions = <PrescriptionId>[];
  PatientId? patientId;
  StaffMemberId? doctorId;
}
