// import 'dart:async';

// import 'package:faker/faker.dart';
// import 'package:hospital/main.dart';
// import 'package:hospital/domain/models/patient.dart';

// final patientsRepository = PatientsRepository();

// class PatientsRepository extends CRUD<Patient> {
//   Iterable<Patient> getByStatus([Status status = Status.waiting]) {
//     return switch (status) {
//       Status.waiting => getAll().where((pt) => pt.status == status),
//       Status.discharged => getAll().where((pt) => pt.status == status),
//       Status.admitted => getAll().where((pt) => pt.status == status),
//       Status.referred => getAll().where((pt) => pt.status == status),
//     };
//   }

//   Timer? timer;
//   PatientsRepository() {
//     timer = Timer.periodic(1.seconds, update);
//   }

//   double get value => remainingTimeForNextPatient / totalTimeForPatient;
//   int totalTimeForPatient = 1;
//   int remainingTimeForNextPatient = 0;
//   void update(_) {
//     // getAll().forEach((a) => print(a.name));
//     cleanup();
//     if (remainingTimeForNextPatient > 0) {
//       remainingTimeForNextPatient--;
//       remainingTimeForNextPatientController.add(value);
//     } else {
//       generatePatient();
//     }
//     // print(remainingTimeForNextPatient);
//     // print(totalTimeForPatient);
//     // print(value);
//   }

//   void generatePatient() {
//     Patient pt = Patient()
//       ..id = faker.randomGenerator.integer(2)
//       ..name = faker.person.name()
//       ..satisfaction = faker.randomGenerator.decimal();
//     remainingTimeForNextPatient = faker.randomGenerator.integer(60, min: 30);
//     put(pt..remainingTime = remainingTimeForNextPatient);
//     totalTimeForPatient = remainingTimeForNextPatient;
//   }

//   void cleanup() {
//     for (final pt in getAll()) {
//       if (pt.status == Status.discharged) {
//         remove(pt.id);
//       }
//     }
//   }

//   /// REMAINIG TIME FOR NEXT PATIENT
//   final remainingTimeForNextPatientController =
//       StreamController<double>.broadcast();
// }

// final waitingPatients = WaitingPatients();

// class WaitingPatients {
//   final controller = StreamController<Iterable<Patient>>.broadcast();
//   Stream<Iterable<Patient>> get stream => controller.stream;
//   final cache = <int, Patient>{};
//   void put(Patient pt) {
//     cache[pt.id] = pt;
//     controller.add(waiting);
//   }

//   void remove(int id) {
//     cache.remove(id);
//     controller.add(waiting);
//   }

//   Iterable<Patient> get waiting => cache.values;
//   int get length => cache.length;
//   Patient? get(int id) => cache[id];
//   void clear() {
//     cache.clear();
//     controller.add(waiting);
//   }
// }
