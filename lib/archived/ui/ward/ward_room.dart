// import 'package:flutter/material.dart';
// import 'package:hospital/archived/business/patients.dart';
// import 'package:hospital/archived/business/staffing.dart';
// import 'package:hospital/archived/data/models/patient.dart';
// import 'package:hospital/archived/data/models/staff.dart';
// import 'package:hospital/archived/ui/shared/metric_tile.dart';
// import 'package:hospital/archived/ui/shared/panel_card.dart';
// import 'package:hospital/archived/ui/shared/status_badge.dart';
// import 'package:hospital/managers/manager.dart';

// class WardRoom extends UI {
//   const WardRoom({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final nurse = activeStaffForRole(StaffRole.nurse);
//     final functional = isWardFunctional();

//     return Scaffold(
//       appBar: AppBar(title: const Text('Ward & Nursing')),
//       body: ListView(
//         padding: const EdgeInsets.all(12),
//         children: [
//           Wrap(
//             spacing: 10,
//             runSpacing: 10,
//             children: [
//               MetricTile(
//                 icon: Icons.vaccines_outlined,
//                 label: 'Nurse',
//                 value: nurse?.name ?? 'None',
//                 active: functional,
//                 width: 230,
//               ),
//               MetricTile(
//                 icon: Icons.hotel_outlined,
//                 label: 'Waiting',
//                 value: '${wardReferralPatients.length}',
//               ),
//               MetricTile(
//                 icon: Icons.fact_check_outlined,
//                 label: 'Treated',
//                 value: '${wardTreatedPatientCount()}',
//                 active: wardTreatedPatientCount() > 0,
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           LayoutBuilder(
//             builder: (context, constraints) {
//               final wide = constraints.maxWidth >= 760;

//               if (wide) {
//                 return const SizedBox(
//                   height: 560,
//                   child: Row(
//                     spacing: 12,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Expanded(child: _WardProcedurePanel()),
//                       Expanded(child: _WardReferralPanel()),
//                     ],
//                   ),
//                 );
//               }

//               return const Column(
//                 children: [
//                   SizedBox(height: 420, child: _WardProcedurePanel()),
//                   SizedBox(height: 12),
//                   SizedBox(height: 460, child: _WardReferralPanel()),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _WardProcedurePanel extends UI {
//   const _WardProcedurePanel();

//   @override
//   Widget build(BuildContext context) {
//     final functional = isWardFunctional();
//     final patient = activeWardPatient();
//     final hasPatient = patient != null;

//     return PanelCard(
//       title: 'Nursing Bay',
//       icon: Icons.vaccines_outlined,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 220),
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: hasPatient
//                     ? Theme.of(
//                         context,
//                       ).colorScheme.primaryContainer.withValues(alpha: 0.45)
//                     : Theme.of(context).colorScheme.surfaceContainerHighest,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: hasPatient
//                   ? _ActiveWardPatient(patient: patient)
//                   : _EmptyWard(functional: functional),
//             ),
//           ),
//           const SizedBox(height: 12),
//           Row(
//             children: [
//               Expanded(
//                 child: OutlinedButton.icon(
//                   onPressed:
//                       functional &&
//                           !hasPatient &&
//                           wardReferralPatients.isNotEmpty
//                       ? callNextWardPatient
//                       : null,
//                   icon: const Icon(Icons.login_outlined),
//                   label: const Text('Call Next'),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: FilledButton.icon(
//                   onPressed: functional && hasPatient
//                       ? dischargeWardPatient
//                       : null,
//                   icon: const Icon(Icons.done_all_outlined),
//                   label: const Text('Complete Care'),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _WardReferralPanel extends UI {
//   const _WardReferralPanel();

//   @override
//   Widget build(BuildContext context) {
//     final canSelect = isWardFunctional() && activeWardPatient() == null;

//     return PanelCard(
//       title: 'Nursing Queue',
//       icon: Icons.hotel_outlined,
//       child: wardReferralPatients.isEmpty
//           ? const Center(child: Text('No ward referrals'))
//           : ListView.separated(
//               itemCount: wardReferralPatients.length,
//               separatorBuilder: (_, _) => const SizedBox(height: 8),
//               itemBuilder: (context, index) {
//                 final patient = wardReferralPatients[index];
//                 return _WardPatientTile(patient: patient, enabled: canSelect);
//               },
//             ),
//     );
//   }
// }

// class _ActiveWardPatient extends StatelessWidget {
//   const _ActiveWardPatient({required this.patient});

//   final Patient patient;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           Icons.medication_liquid_outlined,
//           size: 54,
//           color: Theme.of(context).colorScheme.primary,
//         ),
//         const SizedBox(height: 12),
//         Text(
//           patient.name,
//           textAlign: TextAlign.center,
//           style: Theme.of(
//             context,
//           ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
//         ),
//         const SizedBox(height: 6),
//         Text(
//           patient.concern,
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//             color: Theme.of(context).colorScheme.onSurfaceVariant,
//           ),
//         ),
//         const SizedBox(height: 12),
//         const StatusBadge(
//           icon: Icons.vaccines_outlined,
//           label: 'Nursing care active',
//         ),
//       ],
//     );
//   }
// }

// class _EmptyWard extends StatelessWidget {
//   const _EmptyWard({required this.functional});

//   final bool functional;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           functional ? Icons.event_seat_outlined : Icons.warning_amber_rounded,
//           size: 48,
//           color: Theme.of(context).colorScheme.onSurfaceVariant,
//         ),
//         const SizedBox(height: 10),
//         Text(
//           functional ? 'No nursing case active' : 'Ward blocked',
//           textAlign: TextAlign.center,
//           style: Theme.of(
//             context,
//           ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           functional
//               ? 'Call the next ward referral.'
//               : 'Assign a nurse from admin office.',
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.bodySmall?.copyWith(
//             color: Theme.of(context).colorScheme.onSurfaceVariant,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _WardPatientTile extends StatelessWidget {
//   const _WardPatientTile({required this.patient, required this.enabled});

//   final Patient patient;
//   final bool enabled;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: enabled ? () => selectWardPatient(patient) : null,
//         borderRadius: BorderRadius.circular(8),
//         child: Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: Theme.of(context).colorScheme.surfaceContainerHighest,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(
//               color: enabled
//                   ? Theme.of(context).colorScheme.outlineVariant
//                   : Colors.transparent,
//             ),
//           ),
//           child: Row(
//             children: [
//               Icon(enabled ? Icons.hotel_outlined : Icons.lock_outline),
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
//                 'Rs. ${(patient.fee * 0.75).toStringAsFixed(0)}',
//                 style: Theme.of(
//                   context,
//                 ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
