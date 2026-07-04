// import 'package:flutter/material.dart';
// import 'package:hospital/archived/business/revenue.dart';
// import 'package:hospital/archived/ui/admin/duty_panel.dart';
// import 'package:hospital/archived/ui/admin/finance_receipts_panel.dart';
// import 'package:hospital/archived/ui/admin/hiring_panel.dart';
// import 'package:hospital/archived/ui/admin/operations_overview.dart';
// import 'package:hospital/managers/manager.dart';

// class AdminOffice extends UI {
//   const AdminOffice({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Admin Office'),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 12),
//               child: Center(
//                 child: Text(
//                   'Rs. ${hospitalRevenue().toStringAsFixed(0)}',
//                   style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//           bottom: const TabBar(
//             tabs: [
//               Tab(icon: Icon(Icons.monitor_heart_outlined), text: 'Overview'),
//               Tab(icon: Icon(Icons.assignment_ind_outlined), text: 'Duties'),
//               Tab(icon: Icon(Icons.groups_2_outlined), text: 'Staff'),
//               Tab(icon: Icon(Icons.receipt_long_outlined), text: 'Finance'),
//             ],
//           ),
//         ),
//         body: const TabBarView(
//           children: [
//             _AdminTab(child: OperationsOverview()),
//             _AdminTab(child: DutyPanel()),
//             _AdminTab(child: HiringPanel()),
//             _AdminTab(child: FinanceReceiptsPanel()),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _AdminTab extends StatelessWidget {
//   const _AdminTab({required this.child});

//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(padding: const EdgeInsets.all(12), child: child);
//   }
// }
