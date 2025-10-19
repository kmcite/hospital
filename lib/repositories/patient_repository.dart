import 'package:hospital/repositories/crud_repository.dart';
import 'package:objectbox/objectbox.dart';

import '../models/objectbox_models.dart';

class PatientsRepository extends CrudRepository<Patient> {
  final Store store;

  PatientsRepository(this.store);
  Future<void> addMedicalRecord(int patientId, MedicalRecord record) async {
    final patient = await get(patientId);
    if (patient != null) {
      record.patient.target = patient;
      patient.medicalRecords.add(record);
      put(patient);
    }
  }
}
