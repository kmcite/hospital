// import 'package:flutter/material.dart';
// import 'package:hospital/archived/business/patients.dart';
// import 'package:hospital/archived/data/models/patient.dart';

// class MinorOtProcedurePanel extends StatelessWidget {
//   const MinorOtProcedurePanel({
//     super.key,
//     required this.patient,
//     required this.functional,
//   });

//   final Patient? patient;
//   final bool functional;

//   @override
//   Widget build(BuildContext context) {
//     final hasPatient = patient != null;

//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 220),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: hasPatient
//             ? Theme.of(
//                 context,
//               ).colorScheme.primaryContainer.withValues(alpha: 0.45)
//             : Theme.of(context).colorScheme.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(
//             child: hasPatient
//                 ? _ActiveMinorOtPatient(patient: patient!)
//                 : _EmptyProcedure(functional: functional),
//           ),
//           const SizedBox(height: 12),
//           Row(
//             children: [
//               Expanded(
//                 child: OutlinedButton.icon(
//                   onPressed:
//                       functional && !hasPatient && minorOtPatients.isNotEmpty
//                       ? callNextMinorOtPatient
//                       : null,
//                   icon: const Icon(Icons.login_outlined),
//                   label: const Text('Call Next'),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: FilledButton.icon(
//                   onPressed: functional && hasPatient
//                       ? dischargeMinorOtPatient
//                       : null,
//                   icon: const Icon(Icons.done_all_outlined),
//                   label: const Text('Discharge'),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _ActiveMinorOtPatient extends StatelessWidget {
//   const _ActiveMinorOtPatient({required this.patient});

//   final Patient patient;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           Icons.personal_injury_outlined,
//           size: 48,
//           color: Theme.of(context).colorScheme.primary,
//         ),
//         const SizedBox(height: 10),
//         Text(
//           patient.name,
//           textAlign: TextAlign.center,
//           overflow: TextOverflow.ellipsis,
//           style: Theme.of(context).textTheme.titleLarge?.copyWith(
//             fontWeight: FontWeight.w900,
//           ),
//         ),
//         const SizedBox(height: 6),
//         Text(
//           patient.concern,
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//             color: Theme.of(context).colorScheme.onSurfaceVariant,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _EmptyProcedure extends StatelessWidget {
//   const _EmptyProcedure({required this.functional});

//   final bool functional;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           functional ? Icons.event_seat_outlined : Icons.warning_amber_rounded,
//           size: 46,
//           color: Theme.of(context).colorScheme.onSurfaceVariant,
//         ),
//         const SizedBox(height: 10),
//         Text(
//           functional ? 'No procedure active' : 'Minor OT blocked',
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.w800,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           functional
//               ? 'Call the next referred patient.'
//               : 'Assign an OT assistant from admin office.',
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.bodySmall?.copyWith(
//             color: Theme.of(context).colorScheme.onSurfaceVariant,
//           ),
//         ),
//       ],
//     );
//   }
// }
