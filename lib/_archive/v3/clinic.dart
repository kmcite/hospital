// import 'package:flutter/material.dart';
// import 'package:forui/forui.dart';
// import 'package:hospital/main.dart';
// import 'package:hospital/_archive/v2/v2.dart';
// import 'package:hospital/_archive/v3/clinic_bloc.dart';
// import 'package:hospital/_archive/v3/hiring_manager.dart';
// import 'package:hospital/_archive/v3/staff.dart';

// class ClinicPage extends UI {
//   const ClinicPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FScaffold(
//       header: Header(
//           // title: const Text('ADN CLINIC')
//           ),
//       child: Column(
//         spacing: 8,
//         children: [
//           // const Header(),
//           Expanded(child: const HiredStaff()),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 2,
//               itemBuilder: (context, index) {
//                 if (index == 0) {
//                   return FTile(
//                     title: 'Patients Queue'.text(),
//                   );
//                 }
//                 return FTile(
//                   title: index.text(),
//                 );
//               },
//             ),
//           ),
//           Expanded(child: const AvailableStaff()),
//         ],
//       ),
//     );
//   }
// }

// class Header extends UI {
//   const Header();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         spacing: 8,
//         children: [
//           FBadge(
//             child: Text(
//               '${clinic.balance} PKR',
//             ),
//           ),
//           FBadge(
//             child: Text(
//               '${clinic.tokenCounter}',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HiredStaff extends UI {
//   const HiredStaff();

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         const Text('Hired Staff:', style: TextStyle(fontSize: 16)),
//         ...hiringManager.hiredStaff.map(
//           (staff) {
//             final doc = staff as Doctor;
//             return Column(
//               children: [
//                 FTile(
//                   title: Text(doc.name),
//                   subtitle: Text(
//                       'Status: ${doc.status.name} | Queue: ${doc.queue.length} | Salary: Rs ${doc.salary}'),
//                   suffix: FButton.icon(
//                     onPress: () {
//                       hiringManager.fire(staff);
//                     },
//                     child: const Text('Fire'),
//                   ),
//                 ),
//                 if (doc.isConsulting)
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text('Consulting: ${doc.patient!.name}'),
//                   ),
//                 if (doc.queue.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Wrap(
//                       spacing: 4,
//                       children: doc.queue.map(
//                         (p) {
//                           return FBadge(
//                             child: Text('${p.name} (${p.priority})'),
//                           );
//                         },
//                       ).toList(),
//                     ),
//                   )
//               ],
//             );
//           },
//         )
//       ],
//     );
//   }
// }

// class AvailableStaff extends UI {
//   const AvailableStaff();

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         Text('Available Doctors').pad(),
//         ...hiringManager.availableStaff.map(
//           (staff) {
//             return FTile(
//               title: Text(staff.name),
//               subtitle: Text('Salary: Rs ${staff.salary}'),
//               suffix: FButton.icon(
//                 onPress: () => hiringManager.hire(staff),
//                 child: const Text('Hire'),
//               ),
//             );
//           },
//         )
//       ],
//     );
//   }
// }
