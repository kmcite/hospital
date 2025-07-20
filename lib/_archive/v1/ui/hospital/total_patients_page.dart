// import 'package:flutter/material.dart';
// import 'package:forui/forui.dart';
// import 'package:hospital/domain/repositories/patients_repository.dart';
// import 'package:hospital/main.dart';
// import 'package:hospital/domain/models/patient.dart';

// void admit(Patient p) {
//   patientsRepository(p..status = Status.admitted);
// }

// void refer(Patient p) {
//   patientsRepository(p..status = Status.referred);
// }

// final _patientsRM = RM.injectStream(
//   patientsRepository.watch,
//   initialState: patientsRepository(),
// );

// void _remove(Patient p) {
//   patientsRepository.remove(p.id);
// }

// void _removeAll() {
//   patientsRepository.removeAll();
// }

// class TotalPatientsPage extends UI {
//   @override
//   Widget build(context) {
//     return FScaffold(
//       header: FHeader(
//         title: 'Patients'.text(),
//         // prefixes: [
//         //   FButton.icon(
//         //     child: const Icon(Icons.arrow_back),
//         //     onPress: navigator.back,
//         //   ),
//         // ],
//         suffixes: [
//           FButton.icon(
//             child: Icon(FIcons.delete),
//             onPress: _removeAll,
//           ),
//         ],
//       ),
//       child: FTileGroup(
//         children: _patientsRM.state.map(
//           (patient) {
//             return FTile(
//               title: Text(patient.name),
//               subtitle: Text(patient.status.toString()),
//               suffix: FButton.icon(
//                 child: Text(patient.remainingTime.toString()),
//                 onPress: () => _remove(patient),
//               ),
//               onPress: patient.status == Status.admitted
//                   ? null
//                   : () => admit(patient),
//             );
//           },
//         ).toList(),
//       ),
//     );
//   }
// }
