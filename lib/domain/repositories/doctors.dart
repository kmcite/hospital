import 'package:hospital/domain/repositories/patients_repository.dart';
import 'package:hospital/main.dart';
// import 'package:manager/crud.dart';

import '../models/doctor.dart';
import '../models/patient.dart';
// import 'package:hospital/main.dart';

final doctorsRepository = DoctorsRepository();

class DoctorsRepository extends CRUD<Doctor> {
  Iterable<Doctor> getDoctorsByStatus([
    DoctorStatus status = DoctorStatus.onDuty,
  ]) {
    return getAll().where(
      (dr) {
        return dr.status == status;
      },
    );
  }

  void assignToPatient(Doctor doctor, Patient patient) {
    if (doctor.status != DoctorStatus.onDuty) {
      throw Exception('Doctor must be on duty to be assigned to a patient');
    }
    patient.doctor.target = doctor;
    put(doctor);
  }

  void unassignFromPatient(Doctor doctor, Patient patient) {
    patient.doctor.target = null;
    put(doctor);
  }

  Iterable<Patient> getPatientsForDoctor(Doctor doctor) {
    return patientsRepository.getAll().where(
      (patient) {
        return patient.doctor.target?.id == doctor.id;
      },
    );
  }
}
