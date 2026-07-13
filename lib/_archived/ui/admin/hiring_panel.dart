// import 'package:flutter/material.dart';
// import 'package:hospital/archived/business/staff_generation.dart';
// import 'package:hospital/archived/business/staffing.dart';
// import 'package:hospital/archived/data/models/staff.dart';
// import 'package:hospital/archived/ui/shared/panel_card.dart';
// import 'package:hospital/managers/manager.dart';

// class HiringPanel extends UI {
//   const HiringPanel({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final candidates = generateStaffForHiring.value;
//     final message = lastStaffingMessage();

//     return PanelCard(
//       title: 'Staff Office',
//       icon: Icons.groups_2_outlined,
//       child: ListView(
//         children: [
//           _HiringRefreshBar(),
//           if (message != null) ...[
//             const SizedBox(height: 12),
//             _StatusMessage(message: message),
//           ],
//           const SizedBox(height: 16),
//           Text(
//             'Candidates',
//             style: Theme.of(
//               context,
//             ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
//           ),
//           const SizedBox(height: 8),
//           for (final role in StaffRole.values) ...[
//             _RoleHeader(role: role),
//             const SizedBox(height: 8),
//             for (final staff in candidates.where((staff) => staff.role == role))
//               _CandidateTile(staff: staff),
//             const SizedBox(height: 12),
//           ],
//           const Divider(height: 28),
//           Text(
//             'Hired Staff',
//             style: Theme.of(
//               context,
//             ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
//           ),
//           const SizedBox(height: 8),
//           for (final role in StaffRole.values) ...[
//             _RoleHeader(role: role),
//             const SizedBox(height: 8),
//             if (hiredStaffForRole(role).isEmpty)
//               Text(
//                 'No ${role.label.toLowerCase()} hired.',
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                   color: Theme.of(context).colorScheme.onSurfaceVariant,
//                 ),
//               )
//             else
//               for (final staff in hiredStaffForRole(role))
//                 _EmployeeTile(staff: staff),
//             const SizedBox(height: 12),
//           ],
//         ],
//       ),
//     );
//   }
// }

// class _HiringRefreshBar extends UI {
//   @override
//   Widget build(BuildContext context) {
//     final progress = progressOfGeneration.value;
//     final remaining = remainingStaffGenerationSeconds.value;

//     return Row(
//       children: [
//         Expanded(child: LinearProgressIndicator(value: progress)),
//         const SizedBox(width: 12),
//         Text(
//           '${remaining}s',
//           style: Theme.of(
//             context,
//           ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800),
//         ),
//         const SizedBox(width: 8),
//         IconButton.filledTonal(
//           tooltip: 'Refresh candidates',
//           onPressed: () {
//             refreshHirableStaff();
//             resetStaffGenerationProgress();
//           },
//           icon: const Icon(Icons.refresh),
//         ),
//       ],
//     );
//   }
// }

// class _CandidateTile extends StatelessWidget {
//   const _CandidateTile({required this.staff});

//   final Staff staff;

//   @override
//   Widget build(BuildContext context) {
//     final alreadyHired = hiredStaff.containsKey(staff.id);

//     return Card(
//       margin: const EdgeInsets.only(bottom: 8),
//       child: ListTile(
//         leading: CircleAvatar(child: Icon(_roleIcon(staff.role))),
//         title: Text(staff.name),
//         subtitle: Text(
//           'Signing Rs. ${staff.signingBonus} | Salary Rs. ${staff.salary}/${payrollPeriod.inSeconds}s',
//         ),
//         trailing: FilledButton.icon(
//           onPressed: alreadyHired ? null : () => hireStaff(staff),
//           icon: const Icon(Icons.person_add_alt_1),
//           label: const Text('Hire'),
//         ),
//       ),
//     );
//   }
// }

// class _EmployeeTile extends StatelessWidget {
//   const _EmployeeTile({required this.staff});

//   final Staff staff;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 8),
//       child: ListTile(
//         leading: CircleAvatar(child: Icon(_roleIcon(staff.role))),
//         title: Text(staff.name),
//         subtitle: Text(
//           isStaffOnDuty(staff)
//               ? 'On duty | Severance Rs. ${staff.firingCost}'
//               : 'Available | Severance Rs. ${staff.firingCost}',
//         ),
//         trailing: OutlinedButton.icon(
//           onPressed: () => fireStaff(staff),
//           icon: const Icon(Icons.person_remove_outlined),
//           label: const Text('Fire'),
//         ),
//       ),
//     );
//   }
// }

// class _RoleHeader extends StatelessWidget {
//   const _RoleHeader({required this.role});

//   final StaffRole role;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(_roleIcon(role), size: 18),
//         const SizedBox(width: 8),
//         Text(
//           role.label,
//           style: Theme.of(
//             context,
//           ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800),
//         ),
//       ],
//     );
//   }
// }

// class _StatusMessage extends StatelessWidget {
//   const _StatusMessage({required this.message});

//   final String message;

//   @override
//   Widget build(BuildContext context) {
//     return DecoratedBox(
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.secondaryContainer,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Text(
//           message,
//           style: Theme.of(
//             context,
//           ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
//         ),
//       ),
//     );
//   }
// }

// IconData _roleIcon(StaffRole role) {
//   return switch (role) {
//     StaffRole.receptionist => Icons.support_agent_outlined,
//     StaffRole.doctor => Icons.medical_information_outlined,
//     StaffRole.nurse => Icons.vaccines_outlined,
//     StaffRole.ota => Icons.health_and_safety_outlined,
//   };
// }
