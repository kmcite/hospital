// import 'package:flutter/material.dart';
// import 'package:hospital/archived/business/patients.dart';
// import 'package:hospital/archived/data/models/patient.dart';
// import 'package:hospital/archived/ui/hospital_flow/flow_section.dart';
// import 'package:hospital/archived/ui/shared/metric_tile.dart';
// import 'package:hospital/managers/manager.dart';

// class HospitalFlow extends UI {
//   const HospitalFlow({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Hospital Flow')),
//       body: ListView(
//         padding: const EdgeInsets.all(12),
//         children: [
//           const _FlowMetrics(),
//           const SizedBox(height: 12),
//           FlowSection(
//             title: 'Currently In Care',
//             icon: Icons.medical_services_outlined,
//             groups: [
//               PatientGroup('Consultation', _nullablePatient(activePatient())),
//               PatientGroup('Waiting Queue', waitingPatients.toList()),
//               PatientGroup(
//                 'Minor OT Active',
//                 _nullablePatient(activeMinorOtPatient()),
//               ),
//               PatientGroup('Minor OT Queue', minorOtPatients.toList()),
//               PatientGroup(
//                 'Ward Active',
//                 _nullablePatient(activeWardPatient()),
//               ),
//               PatientGroup('Ward Queue', wardReferralPatients.toList()),
//             ],
//           ),
//           const SizedBox(height: 12),
//           FlowSection(
//             title: 'Cared For',
//             icon: Icons.verified_outlined,
//             groups: [
//               PatientGroup('Discharged Home', homeDischargedPatients.toList()),
//               PatientGroup(
//                 'Minor OT Discharged',
//                 minorOtDischargedPatients.toList(),
//               ),
//               PatientGroup('Ward Discharged', wardDischargedPatients.toList()),
//               PatientGroup('Referred OPD', opdReferralPatients.toList()),
//               PatientGroup('BKMC/MTI Swabi', externalReferralPatients.toList()),
//             ],
//           ),
//           const SizedBox(height: 12),
//           FlowSection(
//             title: 'Ignored',
//             icon: Icons.person_off_outlined,
//             groups: [
//               PatientGroup('Left Waiting Queue', ignoredPatients.toList()),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// List<Patient> _nullablePatient(Patient? patient) {
//   return patient == null ? const [] : [patient];
// }

// class _FlowMetrics extends UI {
//   const _FlowMetrics();

//   @override
//   Widget build(BuildContext context) {
//     final inCareCount =
//         waitingPatients.length +
//         minorOtPatients.length +
//         wardReferralPatients.length +
//         (activePatient() == null ? 0 : 1) +
//         (activeMinorOtPatient() == null ? 0 : 1) +
//         (activeWardPatient() == null ? 0 : 1);
//     final outcomeCount =
//         homeDischargedPatients.length +
//         ignoredPatients.length +
//         opdReferralPatients.length +
//         wardReferralPatients.length +
//         externalReferralPatients.length +
//         minorOtDischargedPatients.length +
//         wardDischargedPatients.length;

//     return Wrap(
//       spacing: 10,
//       runSpacing: 10,
//       children: [
//         MetricTile(
//           icon: Icons.sync_alt,
//           label: 'In Care',
//           value: '$inCareCount',
//         ),
//         MetricTile(
//           icon: Icons.fact_check_outlined,
//           label: 'Outcomes',
//           value: '$outcomeCount',
//         ),
//         MetricTile(
//           icon: Icons.timer_off_outlined,
//           label: 'Ignored',
//           value: '${ignoredPatients.length}',
//         ),
//         MetricTile(
//           icon: Icons.healing_outlined,
//           label: 'Minor OT',
//           value: '${minorOtTreatedPatientCount()}',
//         ),
//         MetricTile(
//           icon: Icons.vaccines_outlined,
//           label: 'Nursing',
//           value: '${wardTreatedPatientCount()}',
//         ),
//       ],
//     );
//   }
// }
