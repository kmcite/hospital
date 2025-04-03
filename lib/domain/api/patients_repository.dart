import 'dart:async';
import 'dart:math' show Random;

import 'package:hospital/domain/api/faker.dart';
import 'package:hospital/domain/api/symptoms_repository.dart';
import 'package:hospital/domain/models/patient.dart';
import 'package:hospital/main.dart';

final patientsRepository = PatientsRepository();

// @dao
// abstract
class PatientsRepository with CRUD<Patient> {
  // @Query('SELECT * FROM Patient WHERE id = :id')
  // Future<Patient?> get(int id);
  // @Query('SELECT * FROM Patient')
  // Future<List<Patient>> getAll();
  // @Query('SELECT * FROM Patient WHERE status = :status')
  // Future<List<Patient>> getPatientsByStatus(Status status);
  // @Query('SELECT * FROM Patient WHERE status = :status')
  // Stream<List<Patient>> watchPatientsByStatus(Status status);

  // @insert
  // Future<void> put(Patient patient);
  // @update
  // Future<void> updatePatient(Patient patient);
  // @delete
  // Future<void> deletePatient(Patient patient);

  Timer? timer;
  PatientsRepository() {
    timer = Timer.periodic(10.seconds, addPatient);
  }

  void addPatient(_) {
    // if (numberOfWaitingPatients() >= 10) {
    //   print('returned');
    //   return;
    // }
    // put(_generatePatient());
  }

  // ignore: unused_element
  Patient _generatePatient() {
    final random = Random();
    // ignore: unused_local_variable
    final symptoms = symptomsRepository.getAll();
    // int numberOfSymptoms = random.nextInt((symptoms.length ~/ 4) + 1);
    // if (numberOfSymptoms > 4) {
    //   numberOfSymptoms = 4;
    // }
    // symptoms..shuffle();
    // ignore: unused_local_variable
    // final symptomsToAdd = symptoms.take(numberOfSymptoms);
    return Patient()
      ..name = faker.person.name()
      // ..symptoms.addAll(symptomsToAdd)
      ..remainingTime = random.nextInt(10) + 5
      ..canPay = random.nextBool()
      ..satisfaction = random.nextDouble()
      ..urgency = Urgency.values[random.nextInt(Urgency.values.length)]
      ..status = Status.waiting;
  }
}
