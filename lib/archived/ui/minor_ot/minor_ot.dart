// import 'package:flutter/material.dart';
// import 'package:hospital/archived/business/patients.dart';
// import 'package:hospital/archived/business/techinician.dart';
// import 'package:hospital/archived/ui/minor_ot/minor_operating_table.dart';
// import 'package:hospital/archived/ui/reception/reception_counter.dart';
// import 'package:hospital/archived/ui/shared/metric_tile.dart';
// import 'package:hospital/managers/manager.dart';

// class MinorOT extends UI {
//   const MinorOT({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final assistant = activeTechnitian();
//     final functional = isMinorOtFunctional();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Minor OT'),
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           final wide = constraints.maxWidth >= 720;
//           const children = [
//             Expanded(child: ReceptionCounter()),
//             Expanded(child: MinorOperatingTable()),
//           ];

//           return ListView(
//             padding: const EdgeInsets.all(12),
//             children: [
//               Wrap(
//                 spacing: 10,
//                 runSpacing: 10,
//                 children: [
//                   MetricTile(
//                     icon: Icons.health_and_safety_outlined,
//                     label: 'Assistant',
//                     value: assistant?.name ?? 'None',
//                     active: functional,
//                     width: 230,
//                   ),
//                   MetricTile(
//                     icon: Icons.healing_outlined,
//                     label: 'Queue',
//                     value: '${minorOtPatients.length}',
//                   ),
//                   MetricTile(
//                     icon: Icons.fact_check_outlined,
//                     label: 'Completed',
//                     value: '${minorOtTreatedPatientCount()}',
//                     active: minorOtTreatedPatientCount() > 0,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               SizedBox(
//                 height: wide ? 620 : 980,
//                 child: wide
//                     ? Row(
//                         spacing: 12,
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: children,
//                       )
//                     : Column(
//                         spacing: 12,
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: children,
//                       ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
