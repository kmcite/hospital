// import 'package:flutter/material.dart';
// import 'package:hospital/archived/business/techinician.dart';
// import 'package:hospital/archived/business/patients.dart';
// import 'package:hospital/archived/ui/minor_ot/procedure_panel.dart';
// import 'package:hospital/archived/ui/minor_ot/referral_queue.dart';
// import 'package:hospital/archived/ui/shared/panel_card.dart';
// import 'package:hospital/managers/manager.dart';

// class MinorOperatingTable extends UI {
//   const MinorOperatingTable({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final assistant = activeTechnitian();
//     final functional = isMinorOtFunctional();

//     return PanelCard(
//       title: 'Minor OT',
//       icon: Icons.healing_outlined,
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Text(
//             assistant == null
//                 ? 'Assign an assistant to start procedures'
//                 : '${assistant.name} managing wounds and dressings',
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//               color: Theme.of(context).colorScheme.onSurfaceVariant,
//             ),
//           ),
//           const SizedBox(height: 18),
//           Expanded(
//             flex: 3,
//             child: MinorOtProcedurePanel(
//               patient: activeMinorOtPatient(),
//               functional: functional,
//             ),
//           ),
//           const SizedBox(height: 14),
//           Expanded(
//             flex: 2,
//             child: MinorOtReferralQueue(functional: functional),
//           ),
//         ],
//       ),
//     );
//   }
// }
