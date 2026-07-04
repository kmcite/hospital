// import 'package:flutter/material.dart';
// import 'package:hospital/archived/business/dark.dart';
// import 'package:hospital/archived/business/receptionists.dart';
// import 'package:hospital/archived/business/revenue.dart';
// import 'package:hospital/archived/business/staffing.dart';
// import 'package:hospital/archived/data/models/staff.dart';
// import 'package:hospital/archived/ui/doctor_room/consultation_panel.dart';
// import 'package:hospital/archived/ui/doctor_room/doctor_overview.dart';
// import 'package:hospital/archived/ui/doctor_room/patient_queue_panel.dart';
// import 'package:hospital/archived/ui/shared/metric_tile.dart';
// import 'package:hospital/archived/ui/shared/status_badge.dart';
// import 'package:hospital/managers/manager.dart';
// import 'package:provider/provider.dart';

// final doctorOverview = signal(false);
// void onDoctorOverviewToggled() {
//   doctorOverview.set(!doctorOverview());
// }

// class DoctorRoom extends UI {
//   const DoctorRoom({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final dark = context.read<DarkManager>();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Doctor Room',
//           style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//             fontWeight: FontWeight.w800,
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 4),
//             child: Center(
//               child: Text(
//                 'Rs. ${hospitalRevenue().toStringAsFixed(0)}',
//                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//             ),
//           ),
//           IconButton(
//             onPressed: dark.toggle,
//             icon: Icon(
//               dark.value ? Icons.dark_mode : Icons.light_mode,
//             ),
//           ),
//           IconButton(
//             onPressed: onDoctorOverviewToggled,
//             icon: Icon(Icons.info),
//           ),
//           const SizedBox(width: 8),
//         ],
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           final wide = constraints.maxWidth >= 760;
//           final doctor = activeStaffForRole(StaffRole.doctor);
//           final receptionist = activeReceptionist();
//           final doctorReady = isDoctorRoomFunctional();
//           final receptionReady = isReceptionOpen();

//           return ListView(
//             padding: const EdgeInsets.all(12),
//             children: [
//               _DoctorRoomHeader(
//                 doctor: doctor,
//                 receptionist: receptionist,
//                 doctorReady: doctorReady,
//                 receptionReady: receptionReady,
//               ),
//               const SizedBox(height: 12),
//               AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 600),
//                 switchInCurve: Curves.easeOutCubic,
//                 switchOutCurve: Curves.easeInCubic,
//                 transitionBuilder: (child, animation) {
//                   return SizeTransition(
//                     sizeFactor: animation,
//                     axisAlignment: -1,
//                     child: FadeTransition(
//                       opacity: animation,
//                       child: child,
//                     ),
//                   );
//                 },
//                 child: doctorOverview()
//                     ? const DoctorOverview(
//                         key: ValueKey('doctor-overview'),
//                       )
//                     : const SizedBox.shrink(
//                         key: ValueKey('doctor-overview-empty'),
//                       ),
//               ),
//               const SizedBox(height: 12),
//               if (wide)
//                 const SizedBox(
//                   height: 520,
//                   child: Row(
//                     spacing: 12,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Expanded(flex: 2, child: ConsultationPanel()),
//                       Expanded(flex: 3, child: PatientQueuePanel()),
//                     ],
//                   ),
//                 )
//               else ...[
//                 const SizedBox(height: 400, child: ConsultationPanel()),
//                 const SizedBox(height: 12),
//                 const SizedBox(height: 500, child: PatientQueuePanel()),
//               ],
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// class _DoctorRoomHeader extends StatelessWidget {
//   const _DoctorRoomHeader({
//     required this.doctor,
//     required this.receptionist,
//     required this.doctorReady,
//     required this.receptionReady,
//   });

//   final Staff? doctor;
//   final Staff? receptionist;
//   final bool doctorReady;
//   final bool receptionReady;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Wrap(
//           spacing: 10,
//           runSpacing: 10,
//           children: [
//             MetricTile(
//               icon: Icons.medical_information_outlined,
//               label: 'Doctor',
//               value: doctor?.name ?? 'Unassigned',
//               active: doctorReady,
//               width: 230,
//             ),
//             MetricTile(
//               icon: Icons.support_agent_outlined,
//               label: 'Reception',
//               value: receptionist?.name ?? 'Closed',
//               active: receptionReady,
//               width: 230,
//             ),
//             MetricTile(
//               icon: Icons.account_balance_wallet_outlined,
//               label: 'Balance',
//               value: 'Rs. ${hospitalRevenue().toStringAsFixed(0)}',
//               active: hospitalRevenue() > 0,
//             ),
//           ],
//         ),
//         if (!doctorReady || !receptionReady) ...[
//           const SizedBox(height: 10),
//           Wrap(
//             spacing: 8,
//             runSpacing: 8,
//             children: [
//               if (!doctorReady)
//                 const StatusBadge(
//                   icon: Icons.medical_services_outlined,
//                   label: 'Assign doctor',
//                   alert: true,
//                 ),
//               if (!receptionReady)
//                 const StatusBadge(
//                   icon: Icons.door_front_door,
//                   label: 'Reception closed',
//                   alert: true,
//                 ),
//             ],
//           ),
//         ],
//       ],
//     );
//   }
// }
