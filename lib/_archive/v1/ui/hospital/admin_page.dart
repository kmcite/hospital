// import 'package:flutter/material.dart';
// import 'package:forui/forui.dart';
// import 'package:hospital/domain/repositories/patients_repository.dart';
// import 'package:hospital/domain/repositories/settings_repository.dart';
// import 'package:hospital/main.dart';

// // String get _name => userRepository.name;

// void _toHospital() {
//   indexRM.animateTo(2);
// }

// bool get isEmergency => false;

// class UserPage extends UI {
//   @override
//   Widget build(BuildContext context) {
//     return FScaffold(
//       header: FHeader(
//         title: "Admin".text(),
//         suffixes: [
//           FButton.icon(
//             child: Icon(isEmergency ? FIcons.heartCrack : FIcons.heart),
//             style: isEmergency
//                 ? FButtonStyle.destructive()
//                 : FButtonStyle.outline(),
//             onPress: () {
//               indexRM.animateTo(3);
//             },
//           ),
//           FButton.icon(
//             child: Icon(FIcons.hospital),
//             onPress: () => _toHospital(),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         spacing: 8,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             margin: const EdgeInsets.symmetric(horizontal: 16),
//             child: const Text(
//               'Welcome! Ready to make a difference in healthcare today? \n🌟',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontStyle: FontStyle.italic,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           ElevatedButton(
//             child: Text('RESOURCES'),
//             onPressed: () {
//               indexRM.animateTo(0);
//             },
//           ),
//           ElevatedButton(
//             child: Text('EMERGENCY'),
//             onPressed: _toHospital,
//           ),
//           ElevatedButton(
//             child: Text('OPD'),
//             onPressed: _toHospital,
//           ),
//           ElevatedButton(
//             child: Text('WARD'),
//             onPressed: _toHospital,
//           ),
//           Card.outlined(
//             child: Column(
//               children: [
//                 'total patients ${patientsRepository().length} '.text().pad(),
//                 Text(
//                   'waiting patients ${patientsRepository.getByStatus().length}',
//                 ).pad()
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
