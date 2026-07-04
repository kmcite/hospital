// import 'package:flutter/material.dart';
// import 'package:hospital/archived/business/patients.dart';
// import 'package:hospital/archived/business/receptionists.dart';
// import 'package:hospital/archived/business/staffing.dart';
// import 'package:hospital/archived/data/models/patient.dart';
// import 'package:hospital/archived/ui/shared/panel_card.dart';
// import 'package:hospital/archived/ui/shared/status_badge.dart';
// import 'package:hospital/managers/manager.dart';

// class PatientQueuePanel extends UI {
//   const PatientQueuePanel({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final canSelectPatient = activePatient() == null;
//     final doctorReady = isDoctorRoomFunctional();
//     final receptionOpen = isReceptionOpen();

//     return PanelCard(
//       title: 'Patients',
//       icon: Icons.groups_outlined,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: OutlinedButton.icon(
//                   onPressed: receptionOpen ? admitWalkInPatient : null,
//                   icon: const Icon(Icons.person_add_alt_1),
//                   label: const Text('Walk-in'),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: OutlinedButton.icon(
//                   onPressed:
//                       waitingPatients.isEmpty ||
//                           activePatient() != null ||
//                           !doctorReady
//                       ? null
//                       : callNextPatient,
//                   icon: const Icon(Icons.login_outlined),
//                   label: const Text('Next'),
//                 ),
//               ),
//             ],
//           ),
//           if (!receptionOpen) ...[
//             const SizedBox(height: 10),
//             const Center(
//               child: StatusBadge(
//                 icon: Icons.door_front_door,
//                 label: 'Reception is closed',
//                 alert: true,
//               ),
//             ),
//           ],
//           if (!doctorReady) ...[
//             const SizedBox(height: 10),
//             const Center(
//               child: StatusBadge(
//                 icon: Icons.medical_services_outlined,
//                 label: 'Doctor room is unstaffed',
//                 alert: true,
//               ),
//             ),
//           ],
//           const SizedBox(height: 14),
//           Expanded(
//             child: waitingPatients.isEmpty
//                 ? const _EmptyPatientQueue()
//                 : ListView.separated(
//                     itemCount: waitingPatients.length,
//                     separatorBuilder: (_, _) => const SizedBox(height: 8),
//                     itemBuilder: (context, index) {
//                       final patient = waitingPatients[index];
//                       return _PatientTile(
//                         patient: patient,
//                         enabled: canSelectPatient && doctorReady,
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _PatientTile extends StatelessWidget {
//   const _PatientTile({required this.patient, required this.enabled});

//   final Patient patient;
//   final bool enabled;

//   @override
//   Widget build(BuildContext context) {
//     patientQueueTick();

//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: enabled ? () => selectWaitingPatient(patient) : null,
//         borderRadius: BorderRadius.circular(8),
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 180),
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
//               CircleAvatar(
//                 backgroundColor: enabled
//                     ? Theme.of(context).colorScheme.primaryContainer
//                     : Theme.of(context).colorScheme.surfaceContainerHighest,
//                 child: Icon(
//                   enabled ? Icons.person_outline : Icons.lock_outline,
//                   color: enabled
//                       ? Theme.of(context).colorScheme.onPrimaryContainer
//                       : Theme.of(context).colorScheme.onSurfaceVariant,
//                 ),
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
//               Text(
//                 'Rs. ${patient.fee}',
//                 style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                   fontWeight: FontWeight.w800,
//                   color: enabled
//                       ? null
//                       : Theme.of(context).colorScheme.onSurfaceVariant,
//                 ),
//               ),
//               const SizedBox(width: 10),
//               _PatienceBadge(remaining: remainingWaitFor(patient)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _PatienceBadge extends StatelessWidget {
//   const _PatienceBadge({required this.remaining});

//   final Duration remaining;

//   @override
//   Widget build(BuildContext context) {
//     final seconds = remaining.inSeconds;
//     final urgent = seconds <= 15;

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//       decoration: BoxDecoration(
//         color: urgent
//             ? Theme.of(context).colorScheme.errorContainer
//             : Theme.of(context).colorScheme.primaryContainer,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Text(
//         '${seconds}s',
//         style: Theme.of(context).textTheme.labelMedium?.copyWith(
//           color: urgent
//               ? Theme.of(context).colorScheme.onErrorContainer
//               : Theme.of(context).colorScheme.onPrimaryContainer,
//           fontWeight: FontWeight.w800,
//         ),
//       ),
//     );
//   }
// }

// class _EmptyPatientQueue extends StatelessWidget {
//   const _EmptyPatientQueue();

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'No one is waiting',
//         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//           color: Theme.of(context).colorScheme.onSurfaceVariant,
//         ),
//       ),
//     );
//   }
// }
