// import 'package:flutter/material.dart';
// import 'package:hospital/archived/business/receptionists.dart';
// import 'package:hospital/archived/business/patients.dart';
// import 'package:hospital/archived/ui/reception/reception_metric.dart';
// import 'package:hospital/archived/ui/shared/status_badge.dart';
// import 'package:hospital/managers/manager.dart';

// class ReceptionCounter extends UI {
//   const ReceptionCounter({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final receptionist = activeReceptionist();
//     final open = isReceptionOpen();

//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Theme.of(context).colorScheme.surface,
//             Theme.of(context).colorScheme.surfaceContainerHighest,
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           color: Theme.of(context).colorScheme.outlineVariant,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.08),
//             blurRadius: 24,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).colorScheme.primaryContainer,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Icon(
//                     Icons.door_front_door,
//                     color: Theme.of(context).colorScheme.onPrimaryContainer,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Reception',
//                         style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         'Assign and monitor front desk duty',
//                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                           color: Theme.of(context).colorScheme.onSurfaceVariant,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 StatusBadge(
//                   icon: open ? Icons.bolt : Icons.lock_outline,
//                   label: open ? 'Open' : 'Closed',
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             AnimatedContainer(
//               duration: const Duration(milliseconds: 250),
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: open
//                     ? Theme.of(
//                         context,
//                       ).colorScheme.primaryContainer.withValues(alpha: 0.45)
//                     : Theme.of(context).colorScheme.surfaceContainerHighest,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 22,
//                     backgroundColor: open
//                         ? Theme.of(context).colorScheme.primary
//                         : Theme.of(context).colorScheme.outline,
//                     child: Icon(
//                       open
//                           ? Icons.check_circle_outline
//                           : Icons.do_not_disturb_on_outlined,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           open
//                               ? 'Reception is on duty'
//                               : 'Reception is closed today',
//                           style: Theme.of(context).textTheme.titleMedium
//                               ?.copyWith(
//                                 fontWeight: FontWeight.w700,
//                               ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           open && receptionist != null
//                               ? 'Currently assigned to ${receptionist.name}'
//                               : 'No receptionist is assigned right now',
//                           style: Theme.of(context).textTheme.bodyMedium
//                               ?.copyWith(
//                                 color: Theme.of(
//                                   context,
//                                 ).colorScheme.onSurfaceVariant,
//                               ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 18),
//             Row(
//               children: [
//                 Expanded(
//                   child: ReceptionMetric(
//                     label: 'Waiting',
//                     value: '${waitingPatients.length}',
//                     icon: Icons.pending_actions_outlined,
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: ReceptionMetric(
//                     label: 'Missed',
//                     value: '${missedReceptionPatientCount()}',
//                     icon: Icons.person_off_outlined,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),

//             Text(
//               open && receptionist != null
//                   ? 'Front desk managed by ${receptionist.name}.'
//                   : 'Select a staff member to open the reception desk.',
//               style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                 color: Theme.of(context).colorScheme.onSurfaceVariant,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
