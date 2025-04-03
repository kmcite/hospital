import 'package:hospital/domain/models/doctor.dart';
import 'package:hospital/main.dart';

final doctorsRepository = DoctorsRepository();

class DoctorsRepository with CRUD<Doctor> {
  Iterable<Doctor> getDoctorsByStatus([
    DoctorStatus status = DoctorStatus.onDuty,
  ]) {
    return getAll().where(
      (dr) {
        return dr.status == status;
      },
    );
  }
  // @Query('SELECT * FROM Doctor WHERE id = :id')
  // Future<Doctor?> get(int id);
  // @Query('SELECT * FROM Doctor')
  // Future<List<Doctor>> getAll();
  // @Query('SELECT * FROM Doctor')
  // Stream<List<Doctor>> watchAll();
  // @Query('SELECT * FROM Doctor WHERE status = :status')
  // Future<List<Doctor>> getDoctorsByStatus(DoctorStatus status);
  // @Query('SELECT * FROM Doctor WHERE status = :status')
  // Stream<List<Doctor>> watchDoctorsByStatus(DoctorStatus status);
  // @insert
  // Future<void> insertDoctor(Doctor doctor);
  // @update
  // Future<void> updateDoctor(Doctor doctor);
  // @delete
  // Future<void> deleteDoctor(Doctor doctor);

  // Iterable<Doctor> get doctorsHired => getDoctorsByStatus();
  // Iterable<Doctor> get doctorsAvailableForHire {
  //   return getDoctorsByStatus(DoctorStatus.availableForHire);
  // }

  // Iterable<Doctor> get doctorsOnDuty => getDoctorsByStatus(DoctorStatus.onDuty);
  // Iterable<Doctor> get doctorsOnLeave {
  //   return getDoctorsByStatus(DoctorStatus.onLeave);
  // }

  // Iterable<Doctor> getDoctorsByStatus([
  //   DoctorStatus status = DoctorStatus.hired,
  // ]) {
  //   return getAll().where((doctor) => doctor.status == status);
  // }

  // void status(Doctor doctor, DoctorStatus _status) {
  //   put(doctor..status = _status);
  // }

  // @deprecated
  // void hire(Doctor doctor) {
  //   put(doctor..status = DoctorStatus.hired);
  // }

  // @deprecated
  // void fire(Doctor doctor) {
  //   put(doctor..status = DoctorStatus.availableForHire);
  // }

  // @deprecated
  // void callForDuty(Doctor doctor) {
  //   put(doctor..status = DoctorStatus.onDuty);
  // }

  // @deprecated
  // void leave(Doctor doctor) {
  //   put(doctor..status = DoctorStatus.onLeave);
  // }
}
