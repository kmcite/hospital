import 'package:hospital/domain/api/faker.dart';
import 'package:hospital/domain/models/patient.dart';
import 'package:hospital/main.dart';

final patientsRepository = PatientsRepository();

class PatientsRepository with CRUD<Patient> {
  int numberOfWaitingPatients() => getPatientsByStatus().length;

  /// get patients by status -> by default waiting patients
  Iterable<Patient> getPatientsByStatus([Status status = Status.waiting]) {
    return getAll().where(
      (patient) => patient.status == status,
    );
  }

  Timer? timer;
  PatientsRepository() {
    timer = Timer.periodic(1.seconds, addPatient);
  }

  void addPatient(_) {
    if (numberOfWaitingPatients() >= 10) {
      print('returned');
      return;
    }
    final patient = Patient();
    patient..name = personFaker.name();
    put(patient);
  }
}
