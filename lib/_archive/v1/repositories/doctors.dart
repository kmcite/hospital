// import 'package:hospital/domain/repositories/patients_repository.dart';
// import 'package:hospital/main.dart';
// // import 'package:manager/crud.dart';

// import '../models/doctor.dart';
// import '../models/patient.dart';
// // import 'package:hospital/main.dart';

// class DoctorsRepositoryMemory {
//   final Map<int, Doctor> _doctors = {};
//   int _nextId = 1;

//   void put(Doctor doctor) {
//     if (doctor.id == 0) {
//       doctor.id = _nextId++;
//       _doctors[doctor.id] = doctor;
//     } else if (_doctors.containsKey(doctor.id)) {
//       _doctors[doctor.id] = doctor;
//     } else {
//       _doctors[doctor.id] = doctor;
//     }
//   }

//   Doctor? get(int id) {
//     return _doctors[id];
//   }

//   List<Doctor> getAll() {
//     return _doctors.values.toList();
//   }

//   void remove(Doctor doctor) {
//     _doctors.remove(doctor.id);
//   }

//   void update(Doctor doctor) {
//     if (!_doctors.containsKey(doctor.id)) {
//       throw Exception('Doctor not found with id: ${doctor.id}');
//     }
//     _doctors[doctor.id] = doctor;
//   }

//   bool exists(int id) {
//     return _doctors.containsKey(id);
//   }
// }

// final doctorsRepository = DoctorsRepository();

// class DoctorsRepository extends CRUD<Doctor> {
//   Iterable<Doctor> getDoctorsByStatus([
//     DoctorStatus status = DoctorStatus.onDuty,
//   ]) {
//     return getAll().where(
//       (dr) {
//         return dr.status == status;
//       },
//     );
//   }

//   void assignToPatient(Doctor doctor, Patient patient) {
//     if (doctor.status != DoctorStatus.onDuty) {
//       throw Exception('Doctor must be on duty to be assigned to a patient');
//     }
//     patient.doctor.target = doctor;
//     put(doctor);
//   }

//   void unassignFromPatient(Doctor doctor, Patient patient) {
//     patient.doctor.target = null;
//     put(doctor);
//   }

//   Iterable<Patient> getPatientsForDoctor(Doctor doctor) {
//     return patientsRepository.getAll().where(
//       (patient) {
//         return patient.doctor.target?.id == doctor.id;
//       },
//     );
//   }
// }
