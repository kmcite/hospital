import 'package:hospital/utils/model.dart';
import 'package:hospital/domain/models/medical_record.dart';

typedef PrescriptionId = int;

class PrescriptionModel extends Model {
  // @Id()
  @override
  PrescriptionId id;
  final String medicineName;
  final String dosage;
  final String frequency;
  // @Property(type: PropertyType.date)
  final DateTime startDate;
  // @Property(type: PropertyType.date)
  final DateTime endDate;
  final String? notes;

  final medicalRecords = <MedicalRecordId>[];
  PrescriptionModel({
    this.id = 0,
    required this.medicineName,
    required this.dosage,
    required this.frequency,
    required this.endDate,
    this.notes,
    DateTime? startDate,
  }) : startDate = startDate ?? DateTime.now();
}
