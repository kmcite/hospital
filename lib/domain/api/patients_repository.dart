import 'dart:async';
import 'dart:math' show Random;

import 'package:hospital/domain/api/faker.dart';
import 'package:hospital/domain/api/symptoms_repository.dart';
import 'package:hospital/domain/models/patient.dart';
import 'package:hospital/main.dart';
import 'package:manager/crud.dart';

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
    timer = Timer.periodic(10.seconds, addPatient);
  }

  void addPatient(_) {
    if (numberOfWaitingPatients() >= 10) {
      print('returned');
      return;
    }
    put(_generatePatient());
  }

  Patient _generatePatient() {
    final random = Random();
    final symptoms = symptomsRepository.getAll();
    int numberOfSymptoms = random.nextInt((symptoms.length ~/ 4) + 1);
    if (numberOfSymptoms > 4) {
      numberOfSymptoms = 4;
    }
    symptoms..shuffle();
    final symptomsToAdd = symptoms.take(numberOfSymptoms);
    return Patient()
      ..name = faker.person.name()
      ..symptoms.addAll(symptomsToAdd)
      ..remainingTime = random.nextInt(10) + 5
      ..canPay = random.nextBool()
      ..satisfaction = random.nextDouble()
      ..urgency = Urgency.values[random.nextInt(Urgency.values.length)]
      ..status = Status.waiting;
  }
}
