// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:forui/forui.dart';
// import 'package:hospital/main.dart';
// import 'package:hospital/_archive/v1/navigator.dart';
// import 'package:hospital/utils/v2.dart';

// class CasualityRoom extends UI {
//   @override
//   Widget build(BuildContext context) {
//     final random =
//         cmo_status.values[Random().nextInt(cmo_status.values.length)];
//     return FScaffold(
//       header: FHeader(
//         title: 'casualty officer room'.text(),
//         suffixes: [
//           FHeaderAction.x(
//             onPress: navigator.back,
//           )
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           'Total patient assessed today 35'.text(),
//           'status: ${random.name}'.text(),
//           'time_out: expected ${random.minutes} minutes'.text(),
//         ],
//       ),
//     );
//   }
// }

// enum cmo_status {
//   assessing_patient_in_room,
//   setting_idle_for_next_patient,
//   inside_ward_with_a_patient,
//   lunch;

//   int get minutes => name.length;
// }
