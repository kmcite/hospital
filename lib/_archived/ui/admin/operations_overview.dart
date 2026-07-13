// import 'package:flutter/material.dart';
// import 'package:hospital/archived/business/receptionists.dart';
// import 'package:hospital/archived/business/revenue.dart';
// import 'package:hospital/archived/business/staffing.dart';
// import 'package:hospital/archived/business/techinician.dart';
// import 'package:hospital/archived/data/models/staff.dart';
// import 'package:hospital/archived/ui/shared/metric_tile.dart';
// import 'package:hospital/archived/ui/shared/panel_card.dart';
// import 'package:hospital/managers/manager.dart';

// class OperationsOverview extends UI {
//   const OperationsOverview({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final onDuty = staffDutySlots.values.whereType<Staff>().length;

//     return PanelCard(
//       title: 'Operations Overview',
//       icon: Icons.monitor_heart_outlined,
//       child: ListView(
//         children: [
//           Wrap(
//             spacing: 10,
//             runSpacing: 10,
//             children: [
//               MetricTile(
//                 icon: Icons.account_balance_wallet_outlined,
//                 label: 'Balance',
//                 value: 'Rs. ${hospitalRevenue().toStringAsFixed(0)}',
//                 active: hospitalRevenue() > 0,
//               ),
//               MetricTile(
//                 icon: Icons.trending_up,
//                 label: 'Income',
//                 value: 'Rs. ${totalIncome().toStringAsFixed(0)}',
//                 active: true,
//               ),
//               MetricTile(
//                 icon: Icons.trending_down,
//                 label: 'Expenses',
//                 value: 'Rs. ${totalExpenses().toStringAsFixed(0)}',
//                 active: totalExpenses() == 0,
//               ),
//               MetricTile(
//                 icon: Icons.door_front_door,
//                 label: 'Reception',
//                 value: isReceptionOpen() ? 'Open' : 'Closed',
//                 active: isReceptionOpen(),
//               ),
//               MetricTile(
//                 icon: Icons.medical_services_outlined,
//                 label: 'Minor OT',
//                 value: isMinorOtFunctional() ? 'Ready' : 'Blocked',
//                 active: isMinorOtFunctional(),
//               ),
//               MetricTile(
//                 icon: Icons.groups_2_outlined,
//                 label: 'Hired Staff',
//                 value: '${hiredStaff.length}',
//                 active: hiredStaff.isNotEmpty,
//               ),
//               MetricTile(
//                 icon: Icons.assignment_turned_in_outlined,
//                 label: 'On Duty',
//                 value: '$onDuty/${StaffRole.values.length}',
//                 active: onDuty == StaffRole.values.length,
//               ),
//               MetricTile(
//                 icon: Icons.payments_outlined,
//                 label: 'Revenue Rate',
//                 value: 'Rs/sec. ${revenueRate().toStringAsFixed(2)}',
//                 active: true,
//               ),
//             ],
//           ),
//           const SizedBox(height: 18),
//           Text(
//             'Staffing',
//             style: Theme.of(
//               context,
//             ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
//           ),
//           const SizedBox(height: 10),
//           for (final role in StaffRole.values)
//             _RoleLine(role: role, active: activeStaffForRole(role)),
//         ],
//       ),
//     );
//   }
// }

// class _RoleLine extends StatelessWidget {
//   const _RoleLine({required this.role, required this.active});

//   final StaffRole role;
//   final Staff? active;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero,
//       leading: Icon(_roleIcon(role)),
//       title: Text(role.label),
//       subtitle: Text('${hiredStaffForRole(role).length} hired'),
//       trailing: Text(
//         active?.name ?? 'Unassigned',
//         style: Theme.of(context).textTheme.labelLarge?.copyWith(
//           fontWeight: FontWeight.w800,
//           color: active == null
//               ? Theme.of(context).colorScheme.error
//               : Theme.of(context).colorScheme.primary,
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
