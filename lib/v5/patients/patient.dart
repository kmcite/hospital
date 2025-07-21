import 'package:hospital/main.dart';
import 'package:hospital/v5/balance/balance.dart';
import 'package:hospital/v5/config/config.dart';
import 'package:hospital/v5/patients/counter.dart';

final patientFees = signal(400.0);
final patientReferalFees = signal(100.0);

class Patient {
  String id = faker.guid.guid();
  String name = faker.person.name();
  String complaints = faker.lorem.sentence();
}

final _patients = mapSignal<String, Patient>({});

final patients = computed(() => _patients.values);

void put_patient(Patient patient) {
  _patients.putIfAbsent(patient.id, () => patient);
}

void remove_patient(Patient patient) {
  _patients.remove(patient.id);
}

/// Manage patient by any doctor

void manage_patient(Patient patient) {
  /// remove from waiting list
  remove_patient(patient);

  /// update counter
  amountOfPatientsManaged.value++;

  /// update balance
  use_balance(patientFees());
}

void refer_patient_elsewhere(Patient patient) {
  remove_patient(patient);
  use_balance(patientReferalFees() + ambulanceFees());
}
