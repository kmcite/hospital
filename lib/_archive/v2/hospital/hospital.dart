// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:forui/forui.dart';
// import 'package:hospital/main.dart';
// import 'package:hospital/_archive/v1/navigator.dart';
// import 'package:hospital/_archive/v2/hospital/admin/admin.dart';
// import 'package:hospital/_archive/v2/hospital/emergency/emergency_part.dart';
// import 'package:hospital/_archive/v2/hospital/patient_flow_row.dart';
// import 'package:hospital/utils/v2.dart';

// Stream<DateTime> time() async* {
//   while (true) {
//     yield DateTime.now();
//     await Future.delayed(1.seconds);
//   }
// }

// final timeRM = RM.injectStream(time, initialState: DateTime.now());

// (int, int, int) get timeNow {
//   final time = timeRM.state;
//   return (
//     time.hour,
//     time.minute,
//     time.second,
//   );
// }

// final moneyRM = 350.0.inj();
// double get money => moneyRM.state;

// class HospitalPage_ extends UI {
//   @override
//   Widget build(BuildContext context) {
//     return FScaffold(
//       header: FHeader(
//         title: 'hospital'.text(),
//         suffixes: [
//           money.text(),
//           timeNow.text(),
//         ],
//       ),
//       child: Column(
//         children: [
//           FCard(
//             title: 'emergency'.text(),
//             subtitle: Column(
//               children: [
//                 FBadge(
//                   child: 'cmo'.text(),
//                 ),
//                 PatientFlowRow(
//                   currentStep: PatientStep.exit,
//                 )
//               ],
//             ),
//           ),
//           Column(
//             children: List.generate(
//               HospitalParts.values.length,
//               (i) {
//                 final part = HospitalParts.values[i];
//                 return FButton(
//                   onPress: () {
//                     navigator.to(part());
//                   },
//                   child: part.name.text(),
//                 ).pad();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// enum HospitalParts {
//   emergency,
//   opd,
//   main_ot,
//   admin,
//   general_wards,
//   thalassemia;

//   Widget call() {
//     return switch (this) {
//       HospitalParts.emergency => EmergencyPart(),
//       HospitalParts.opd => throw UnimplementedError(),
//       HospitalParts.main_ot => throw UnimplementedError(),
//       HospitalParts.admin => AdminPart(),
//       HospitalParts.general_wards => throw UnimplementedError(),
//       HospitalParts.thalassemia => throw UnimplementedError(),
//     };
//   }
// }
