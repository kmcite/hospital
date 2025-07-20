// import 'package:flutter/material.dart';
// import 'package:forui/forui.dart';
// import 'package:hospital/main.dart';
// import 'package:hospital/_archive/v1/navigator.dart';
// import 'package:hospital/_archive/v2/hospital/emergency/emergency_parts.dart';
// import 'package:hospital/utils/v2.dart';

// class EmergencyPart extends UI {
//   @override
//   Widget build(BuildContext context) {
//     return FScaffold(
//       header: FHeader(
//         title: 'emergency'.text(),
//         suffixes: [
//           FHeaderAction.x(onPress: navigator.back),
//         ],
//       ),
//       child: Column(
//         children: List.generate(
//           EmergencyParts.values.length,
//           (i) {
//             final part = EmergencyParts.values[i];
//             return FButton(
//               onPress: () {
//                 navigator.to(part());
//               },
//               child: part.name.text(),
//             ).pad();
//           },
//         ),
//       ),
//     );
//   }
// }
