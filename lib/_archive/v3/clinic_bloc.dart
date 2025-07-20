// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:hospital/_archive/v3/hiring_manager.dart';
// import 'package:hospital/_archive/v3/staff.dart';

// final clinic = ClinicBloc();

// class ClinicBloc extends ChangeNotifier {
//   ///
//   int balance = 150000;

//   /// TOKEN
//   Timer? patientSpawner;
//   int tokenCounter = 1;

//   ClinicBloc() {
//     _startPatientFlow();
//   }
//   final patientQueue = <Patient>[];
//   void _startPatientFlow() {
//     patientSpawner = Timer.periodic(
//       Duration(seconds: 2),
//       (_) {
//         if (hiringManager.doctors.isEmpty) return;
//         final newPatient = Patient.generate(tokenCounter++);
//         // assign to doctor with shortest queue
//         hiringManager.doctors.toList()
//           ..sort((a, b) => a.queue.length.compareTo(b.queue.length))
//           ..first.queue.add(newPatient);
//         // Optionally notify listeners/UI here
//       },
//     );
//   }
// }
