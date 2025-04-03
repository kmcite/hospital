// import 'package:flutter/material.dart';
// import 'package:hospital/domain/api/doctors.dart';
// import 'package:hospital/main.dart';
// import 'package:hospital/navigator.dart';

// class DutyAssignmentDialog extends UI {
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: doctorsRepository.getAll().isEmpty
//           ? 'NO DOCTORS'.text()
//           : ListView(
//               shrinkWrap: true,
//               children: [
//                 // ...doctorsRepository.getAll().map(
//                 //   (doctor) {
//                 //     return ListTile(
//                 //       onTap: () {
//                 //         navigator.back();
//                 //       },
//                 //       title: doctor.name.text(),
//                 //     );
//                 //   },
//                 // ),
//               ],
//             ).pad(),
//     );
//   }
// }
