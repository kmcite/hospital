// import 'package:flutter/material.dart';
// import 'package:hospital/archived/business/patients.dart';
// import 'package:hospital/archived/data/models/patient.dart';
// import 'package:hospital/managers/manager.dart';

// class MinorOtReferralQueue extends UI {
//   const MinorOtReferralQueue({super.key, required this.functional});

//   final bool functional;

//   @override
//   Widget build(BuildContext context) {
//     final canSelect = functional && activeMinorOtPatient() == null;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: Text(
//                 'Referred Patients',
//                 style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//             ),
//             _QueueCount(count: minorOtPatients.length),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Expanded(
//           child: minorOtPatients.isEmpty
//               ? Center(
//                   child: Text(
//                     'No Minor OT referrals',
//                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       color: Theme.of(context).colorScheme.onSurfaceVariant,
//                     ),
//                   ),
//                 )
//               : ListView.separated(
//                   itemCount: minorOtPatients.length,
//                   separatorBuilder: (_, _) => const SizedBox(height: 8),
//                   itemBuilder: (context, index) {
//                     final patient = minorOtPatients[index];
//                     return _MinorOtPatientTile(
//                       patient: patient,
//                       enabled: canSelect,
//                     );
//                   },
//                 ),
//         ),
//       ],
//     );
//   }
// }

// class _MinorOtPatientTile extends StatelessWidget {
//   const _MinorOtPatientTile({required this.patient, required this.enabled});

//   final Patient patient;
//   final bool enabled;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: enabled ? () => selectMinorOtPatient(patient) : null,
//         borderRadius: BorderRadius.circular(8),
//         child: Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: enabled
//                 ? Theme.of(context).colorScheme.surfaceContainerHighest
//                 : Theme.of(
//                     context,
//                   ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(
//               color: enabled
//                   ? Theme.of(context).colorScheme.outlineVariant
//                   : Colors.transparent,
//             ),
//           ),
//           child: Row(
//             children: [
//               Icon(
//                 enabled ? Icons.healing_outlined : Icons.lock_outline,
//                 color: Theme.of(context).colorScheme.onSurfaceVariant,
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       patient.name,
//                       overflow: TextOverflow.ellipsis,
//                       style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       patient.concern,
//                       overflow: TextOverflow.ellipsis,
//                       style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                         color: Theme.of(context).colorScheme.onSurfaceVariant,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _QueueCount extends StatelessWidget {
//   const _QueueCount({required this.count});

//   final int count;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.primaryContainer,
//         borderRadius: BorderRadius.circular(999),
//       ),
//       child: Text(
//         '$count',
//         style: Theme.of(context).textTheme.labelLarge?.copyWith(
//           color: Theme.of(context).colorScheme.onPrimaryContainer,
//           fontWeight: FontWeight.w800,
//         ),
//       ),
//     );
//   }
// }
