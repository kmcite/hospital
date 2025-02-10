import 'package:hospital/hospital/patients/patient.dart';
import 'package:hospital/main.dart';

class AdmittedPatientsRepository {
  List<Patient> patients = [];

  void admitPatient(Patient p) {
    print('patient admitted $p');
    patients.add(p);
  }

  void dischargePatient(Patient p) {
    patients = List.of(patients.where((pa) => pa.id != p.id));
    print('discharged $p');
  }
}

final admittedPatientsRepositoryRM =
    RM.inject(() => AdmittedPatientsRepository());

final availableBedsRM = RM.inject(() => AvailableBeds());

class AvailableBeds {
  int beds = 4;
  add() {
    beds++;
  }

  remove() {
    beds--;
  }
}
