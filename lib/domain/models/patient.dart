import 'package:hospital/domain/models/medical_record.dart';
import 'package:hospital/utils/in_memory_collection.dart';
import 'package:hospital/utils/model.dart';
// import 'package:objectbox/objectbox.dart';

class Patients extends InMemoryCollection<PatientModel> {}

typedef PatientId = int;

// @Entity()
class PatientModel extends Model {
  // @Id()
  @override
  PatientId id;
  final String name;
  final int age;
  final String gender;
  // @Property(type: PropertyType.date)
  final DateTime registrationDate;
  // RECORDS
  final medicalRecords = <MedicalRecordId>[];

  PatientModel({
    this.id = 0,
    required this.name,
    required this.age,
    required this.gender,
    DateTime? registrationDate,
  }) : registrationDate = registrationDate ?? DateTime.now();
}
