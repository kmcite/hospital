// import 'package:flutter/material.dart';
// import 'package:forui/forui.dart';
// import 'package:hospital/main.dart';
// import 'package:hospital/_archive/v1/navigator.dart';
// import 'package:hospital/utils/v2.dart';

// class AdminPart extends UI {
//   @override
//   Widget build(BuildContext context) {
//     return FScaffold(
//       header: FHeader(
//         title: 'ADMIN'.text(),
//         suffixes: [
//           FHeaderAction.x(onPress: navigator.back),
//         ],
//       ),
//       child: Column(
//         children: List.generate(
//           AdminParts.values.length,
//           (i) {
//             final part = AdminParts.values[i];
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

// enum AdminParts {
//   ms_office,
//   finance,
//   administration;

//   Widget call() => switch (this) {
//         AdminParts.ms_office => Text('data'),
//         AdminParts.finance => Text('data'),
//         AdminParts.administration => Text('data'),
//       };
// }
