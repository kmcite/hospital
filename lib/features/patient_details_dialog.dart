// import 'dart:developer' show log;
import 'package:flutter/material.dart';
import 'package:hospital/api/consultation.dart';
import 'package:hospital/api/models.dart';
// import 'package:hospital/data/patient.dart';
// import 'package:hospital/components/treatment_options_selector.dart';
// import 'package:hospital/utils/navigation.dart';

class PatientDetailsDialog extends StatelessWidget {
  final Consultation patient;

  const PatientDetailsDialog({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    // final status = patient.status.value;
    // final remMs = patient.remainingTime.value;
    // final treatmentProgress = patient.treatmentProgress.value;
    // final isWaiting = status == PatientStatus.waiting;
    // final remainingTime = (remMs / patient.maxTime).clamp(0.0, 1.0);

    return AlertDialog(
      title: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text('${patient.chit.name}'),
          // if (isWaiting) CircularProgressIndicator(),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Status: ${status.name.toUpperCase()}\n' +
            //       (isWaiting
            //           ? 'Time remaining: ${remMs.toStringAsFixed(1)}s\n'
            //           : '') +
            //       'Symptoms: ${patient.presentingComplaints}',
            //   style: const TextStyle(fontSize: 16),
            // ),
            // if (isWaiting) ...[
            //   const Text(
            //     'Remainig Time for Treatment',
            //     style: TextStyle(fontWeight: FontWeight.bold),
            //   ),
            //   // const SizedBox(height: 16),
            //   LinearProgressIndicator(
            //     value: remainingTime,
            //     minHeight: 8,
            //     borderRadius: BorderRadius.circular(4),
            //     color: remainingTime < 0.3 ? Colors.red : Colors.green,
            //     backgroundColor: Theme.of(
            //       context,
            //     ).colorScheme.surfaceContainerHighest,
            //   ),
            // ],
            // const SizedBox(height: 16),
            const Text(
              'Treatment Progress:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            // const SizedBox(height: 4),
            // LinearProgressIndicator(
            //   value: treatmentProgress,
            //   color: Colors.green,
            //   backgroundColor: Colors.green.withValues(alpha: 0.1),
            // ),
            // const SizedBox(height: 16),
            // if (isWaiting)
            //   TreatmentOptionsSelector(
            //     suggestedOptions: patient.suggestedTreatments,
            //     givenTreatments: patient.givenTreatments,
            //     onOptionSelected: (option) {
            //       log('Treating with: ${option.name}', name: 'TREATMENT');
            //       patient.applyTreatment(option);
            //       if (patient.status.value == PatientStatus.treated) {
            //         navigateBack(); // Auto-close on cure
            //       }
            //     },
            //   ),
          ],
        ),
      ),
      actions: [
        // TextButton(
        //   onPressed: () => navigateBack(),
        //   child: Text(isWaiting ? 'Close' : 'Dismiss'),
        // ),
      ],
    );
  }
}
