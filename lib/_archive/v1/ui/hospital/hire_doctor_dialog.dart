// import 'package:faker/faker.dart';
// import 'package:flutter/material.dart';
// import 'package:hospital/domain/models/doctor.dart';
// import 'package:hospital/main.dart';
// import 'package:hospital/navigator.dart';

// mixin HireDoctorX {
//   late final doctorRM = RM.inject(_generateDoctor);
//   bool get isHiringLimitReached => true;

//   Doctor _generateDoctor() => Doctor()..price = random.integer(200, min: 50);

//   void confirmHiring() {
//     if (isHiringLimitReached) {
//       ScaffoldMessenger.of(RM.context!).showSnackBar(
//         const SnackBar(
//           content:
//               Text('Hiring limit reached. Please upgrade hiring capacity.'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//     navigator.back();
//   }
// }

// class HireDoctorDialog extends UI with HireDoctorX {
//   @override
//   Widget build(context) {
//     final theme = Theme.of(context);
//     return Dialog(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: !isHiringLimitReached
//             ? const Center(
//                 child: Text(
//                   'HIRING LIMIT REACHED',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               )
//             : Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     'HIRE DOCTOR?',
//                     style: theme.textTheme.titleLarge?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Text(
//                             doctorRM.state.name,
//                             style: theme.textTheme.titleMedium,
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             '\$${doctorRM.state.price}',
//                             style: theme.textTheme.headlineSmall?.copyWith(
//                               color: theme.colorScheme.primary,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       IconButton(
//                         onPressed: navigator.back,
//                         icon: const Icon(Icons.close),
//                         tooltip: 'Cancel',
//                       ),
//                       IconButton(
//                         onPressed: () => doctorRM,
//                         icon: const Icon(Icons.refresh),
//                         tooltip: 'Generate New',
//                       ),
//                       IconButton(
//                         onPressed: confirmHiring,
//                         icon: const Icon(Icons.check_circle),
//                         color: theme.colorScheme.primary,
//                         tooltip: 'Confirm Hire',
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }
