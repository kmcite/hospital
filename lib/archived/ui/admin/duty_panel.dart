// import 'package:flutter/material.dart';
// import 'package:hospital/archived/business/staffing.dart';
// import 'package:hospital/archived/data/models/staff.dart';
// import 'package:hospital/archived/ui/shared/panel_card.dart';
// import 'package:hospital/managers/manager.dart';

// class DutyPanel extends UI {
//   const DutyPanel({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return PanelCard(
//       title: 'Duty Control',
//       icon: Icons.assignment_ind_outlined,
//       child: ListView(
//         children: [
//           for (final role in StaffRole.values) ...[
//             _DutySlot(role: role),
//             const SizedBox(height: 12),
//           ],
//         ],
//       ),
//     );
//   }
// }

// class _DutySlot extends UI {
//   const _DutySlot({required this.role});

//   final StaffRole role;

//   @override
//   Widget build(BuildContext context) {
//     final active = activeStaffForRole(role);
//     final candidates = hiredStaffForRole(role).toList();

//     return DecoratedBox(
//       decoration: BoxDecoration(
//         border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               children: [
//                 Icon(_roleIcon(role)),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Text(
//                     role.label,
//                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                 ),
//                 _DutyBadge(active: active != null),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Text(
//               active?.name ?? 'No one assigned',
//               style: Theme.of(
//                 context,
//               ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
//             ),
//             const SizedBox(height: 10),
//             DropdownButtonFormField<Staff?>(
//               value: active,
//               decoration: InputDecoration(
//                 border: const OutlineInputBorder(),
//                 labelText: '${role.label} duty slot',
//               ),
//               items: [
//                 const DropdownMenuItem<Staff?>(
//                   value: null,
//                   child: Text('Clear duty slot'),
//                 ),
//                 for (final staff in candidates)
//                   DropdownMenuItem<Staff?>(
//                     value: staff,
//                     child: Text(staff.name),
//                   ),
//               ],
//               onChanged: (staff) {
//                 assignStaffToDuty(role, staff);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _DutyBadge extends StatelessWidget {
//   const _DutyBadge({required this.active});

//   final bool active;

//   @override
//   Widget build(BuildContext context) {
//     return Chip(
//       avatar: Icon(
//         active ? Icons.check_circle_outline : Icons.pause_circle_outline,
//         size: 18,
//       ),
//       label: Text(active ? 'Assigned' : 'Open'),
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
