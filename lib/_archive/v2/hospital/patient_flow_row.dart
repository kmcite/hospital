// import 'package:flutter/material.dart';
// import 'package:hospital/main.dart';

// enum PatientStep { token, consultation, medication, exit }

// class PatientFlowRow extends UI {
//   final PatientStep currentStep;

//   const PatientFlowRow({required this.currentStep});

//   Widget _stepIcon(PatientStep step, String label, IconData icon) {
//     final isDone = step.index < currentStep.index;
//     final isActive = step == currentStep;

//     return Column(
//       children: [
//         CircleAvatar(
//           backgroundColor: isActive
//               ? Colors.blue
//               : (isDone ? Colors.green : Colors.grey[300]),
//           child: Icon(icon,
//               color: isActive || isDone ? Colors.white : Colors.black54),
//         ),
//         const SizedBox(height: 4),
//         Text(label, style: TextStyle(fontSize: 12)),
//         if (isDone) Icon(Icons.check, color: Colors.green, size: 14),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _stepIcon(PatientStep.token, "Token", Icons.assignment),
//         Icon(Icons.arrow_forward, size: 16),
//         _stepIcon(PatientStep.consultation, "Consult", Icons.medical_services),
//         Icon(Icons.arrow_forward, size: 16),
//         _stepIcon(PatientStep.medication, "Medicine", Icons.local_pharmacy),
//         Icon(Icons.arrow_forward, size: 16),
//         _stepIcon(PatientStep.exit, "Exit", Icons.exit_to_app),
//       ],
//     );
//   }
// }
