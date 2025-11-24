import 'package:hospital/utils/model.dart';
import 'package:hospital/domain/models/medical_record.dart';

typedef SymptomId = int;

class SymptomModel extends Model {
  @override
  final SymptomId id;
  final String name;

  final medicalRecords = <MedicalRecordId>[];

  SymptomModel({
    this.id = 0,
    required this.name,
  });
}
