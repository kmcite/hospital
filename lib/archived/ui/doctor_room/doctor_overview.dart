// import 'package:flutter/material.dart';
// import 'package:hospital/archived/business/patients.dart';
// import 'package:hospital/archived/ui/shared/metric_tile.dart';
// import 'package:hospital/managers/manager.dart';

// class DoctorOverview extends UI {
//   const DoctorOverview({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       spacing: 10,
//       runSpacing: 10,
//       children: [
//         MetricTile(
//           icon: Icons.pending_actions_outlined,
//           label: 'Waiting',
//           value: '${waitingPatients.length}',
//         ),
//         MetricTile(
//           icon: Icons.medical_information_outlined,
//           label: 'Consulted',
//           value: '${consultedPatientCount()}',
//         ),
//         MetricTile(
//           icon: Icons.logout_outlined,
//           label: 'Discharged',
//           value:
//               '${homeDischargedPatients.length + minorOtDischargedPatients.length + wardDischargedPatients.length}',
//         ),
//         MetricTile(
//           icon: Icons.healing_outlined,
//           label: 'Minor OT',
//           value: '${minorOtPatients.length}',
//         ),
//         MetricTile(
//           icon: Icons.fact_check_outlined,
//           label: 'OT Done',
//           value: '${minorOtTreatedPatientCount()}',
//         ),
//         MetricTile(
//           icon: Icons.local_hospital,
//           label: 'OPD',
//           value: '${opdReferralPatients.length}',
//         ),
//         MetricTile(
//           icon: Icons.hotel,
//           label: 'Ward',
//           value: '${wardReferralPatients.length}',
//         ),
//         MetricTile(
//           icon: Icons.vaccines_outlined,
//           label: 'Nursing Done',
//           value: '${wardTreatedPatientCount()}',
//         ),
//         MetricTile(
//           icon: Icons.local_hospital,
//           label: 'BKMC/MTI',
//           value: '${externalReferralPatients.length}',
//         ),
//         MetricTile(
//           icon: Icons.timer_off_outlined,
//           label: 'Left Queue',
//           value: '${abandonedPatientCount()}',
//         ),
//       ],
//     );
//   }
// }
