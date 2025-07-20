// import 'package:faker/faker.dart';

// class Staff {
//   String name = faker.person.name();
//   String id = faker.guid.guid();
//   int salary = 0;
// }

// enum DoctorStatus { consulting, idle }

// class Doctor extends Staff {
//   int salary = 120000;
//   bool get isConsulting => patient != null;
//   DoctorStatus get status {
//     if (isConsulting) {
//       return DoctorStatus.consulting;
//     }
//     return DoctorStatus.idle;
//   }

//   Doctor() {
//     // startConsultationLoop();
//   }

//   Patient? patient;
//   int speedInSeconds = 3;
//   List<Patient> queue = [];
//   // void startConsultationLoop() {
//   //   Timer.periodic(
//   //     Duration(seconds: 1),
//   //     (_) async {
//   //       if (isConsulting || queue.isEmpty) {
//   //         return;
//   //       }
//   //       patient = _getNextPatient();
//   //       clinic.notify();

//   //       await Future.delayed(Duration(seconds: speedInSeconds));
//   //       queue.remove(patient);
//   //       patient = null;
//   //       clinic.balance += 500;
//   //       clinic.notify();
//   //     },
//   //   );
//   // }

//   // Patient _getNextPatient() {
//   //   queue.sort((a, b) => b.priority.compareTo(a.priority));
//   //   return queue.first;
//   // }
// }

// class Nurse extends Staff {
//   int salary = 70000;
// }

// class Ota extends Staff {
//   String name = faker.person.name();
//   int salary = 40000;
// }

// class Patient {
//   String name;
//   String complaint;
//   int token;
//   int priority;

//   Patient({
//     required this.name,
//     required this.complaint,
//     required this.token,
//     required this.priority,
//   });

//   static Patient generate(int token) {
//     return Patient(
//       name: faker.person.name(),
//       complaint: faker.lorem.sentence(),
//       token: token,
//       priority: faker.randomGenerator.integer(3) + 1, // 1 = low, 3 = high
//     );
//   }
// }
