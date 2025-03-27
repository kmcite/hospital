import 'package:hospital/domain/models/doctor.dart';
import 'package:manager/crud.dart';

final doctorsRepository = DoctorsRepository();

class DoctorsRepository with CRUD<Doctor> {
  Iterable<Doctor> get doctorsHired => getDoctorsByStatus();
  Iterable<Doctor> get doctorsAvailableForHire {
    return getDoctorsByStatus(DoctorStatus.availableForHire);
  }

  Iterable<Doctor> get doctorsOnDuty => getDoctorsByStatus(DoctorStatus.onDuty);
  Iterable<Doctor> get doctorsOnLeave {
    return getDoctorsByStatus(DoctorStatus.onLeave);
  }

  Iterable<Doctor> getDoctorsByStatus([
    DoctorStatus status = DoctorStatus.hired,
  ]) {
    return getAll().where((doctor) => doctor.status == status);
  }

  void status(Doctor doctor, DoctorStatus _status) {
    put(doctor..status = _status);
  }

  @deprecated
  void hire(Doctor doctor) {
    put(doctor..status = DoctorStatus.hired);
  }

  @deprecated
  void fire(Doctor doctor) {
    put(doctor..status = DoctorStatus.availableForHire);
  }

  @deprecated
  void callForDuty(Doctor doctor) {
    put(doctor..status = DoctorStatus.onDuty);
  }

  @deprecated
  void leave(Doctor doctor) {
    put(doctor..status = DoctorStatus.onLeave);
  }
}
