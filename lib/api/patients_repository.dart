import 'dart:async';

import 'package:faker/faker.dart';
import 'package:hospital/models/patient.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'crud.dart' show CRUD;

final patientsRepository = PatientsRepository();

class PatientsRepository extends CRUD<Patient> {
  Iterable<Patient> getByStatus([Status status = Status.waiting]) {
    return switch (status) {
      Status.waiting => getAll().where((pt) => pt.status == status),
      Status.discharged => getAll().where((pt) => pt.status == status),
      Status.admitted => getAll().where((pt) => pt.status == status),
      Status.referred => getAll().where((pt) => pt.status == status),
    };
  }

  Timer? timer;
  PatientsRepository() {
    timer = Timer.periodic(1.seconds, update);
  }

  double get value => remainingTimeForNextPatient / totalTimeForPatient;
  int totalTimeForPatient = 1;
  int remainingTimeForNextPatient = 0;
  void update(_) {
    getAll().forEach((a) => print(a.name));
    updateAllPatients();
    if (remainingTimeForNextPatient > 0) {
      remainingTimeForNextPatient--;
    } else {
      generatePatient();
    }
    notifyListeners();
    print(remainingTimeForNextPatient);
    print(totalTimeForPatient);
    print(value);
  }

  void generatePatient() {
    Patient pt = Patient()
      ..id = faker.randomGenerator.integer(2)
      ..name = faker.person.name()
      ..satisfaction = faker.randomGenerator.decimal();
    remainingTimeForNextPatient = faker.randomGenerator.integer(60, min: 30);
    put(pt..remainingTime = remainingTimeForNextPatient);
    totalTimeForPatient = remainingTimeForNextPatient;
  }

  void updateAllPatients() {
    for (final pt in getAll()) {
      if (pt.status == Status.discharged) {
        remove(pt.id);
      }
    }
  }
}

abstract class Model {
  int get id;
}
