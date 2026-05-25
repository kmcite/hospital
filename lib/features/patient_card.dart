import 'package:flutter/material.dart';
import 'package:hospital/api/models.dart';
import 'package:hospital/api/patient.dart';
// import 'package:hospital/data/patient.dart';
// import 'package:hospital/features/patient_details_dialog.dart';
// import 'package:hospital/utils/navigation.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  const PatientCard({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    // final status = patient.status.value;
    // final remMs = patient.remainingTime.value; // listens to this signal
    // final progress = (remMs / patient.maxTime).clamp(0.0, 1.0);

    return Card(
      // elevation: status != PatientStatus.waiting ? 2 : 4,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      // color: status == PatientStatus.treated
      //     ? Colors.green.withValues(alpha: 0.1)
      //     : status == PatientStatus.expired
      //     ? Colors.red.withValues(alpha: 0.1)
      //     : null,
      child: InkWell(
        onTap: () {
          // patient.isDialogOpen = true;
          // navigateToDialog(PatientDetailsDialog(patient: patient)).then((_) {
          //   patient.isDialogOpen = false;
          // });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon(
              //   status == PatientStatus.treated
              //       ? Icons.sentiment_very_satisfied
              //       : status == PatientStatus.expired
              //       ? Icons.sentiment_very_dissatisfied
              //       : Icons.person,
              //   size: 36,
              //   color: status == PatientStatus.treated
              //       ? Colors.green
              //       : status == PatientStatus.expired
              //       ? Colors.red
              //       : null,
              // ),
              const SizedBox(height: 6),
              Text(
                patient.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              // if (status == PatientStatus.waiting) ...[
              //   Text(
              //     '${remMs.toStringAsFixed(1)}s',
              //     style: TextStyle(
              //       fontSize: 14,
              //       color: progress < 0.3 ? Colors.red : null,
              //       fontWeight: progress < 0.3 ? FontWeight.bold : null,
              //     ),
              //   ),
              //   const SizedBox(height: 8),
              //   const Text(
              //     'Cure Progress:',
              //     style: TextStyle(fontSize: 10, color: Colors.grey),
              //   ),
              //   const SizedBox(height: 2),
              //   LinearProgressIndicator(
              //     value: patient.treatmentProgress.value,
              //     minHeight: 4,
              //     borderRadius: BorderRadius.circular(2),
              //     color: Colors.blue,
              //     backgroundColor: Colors.blue.withValues(alpha: 0.1),
              //   ),
              //   const SizedBox(height: 4),
              //   LinearProgressIndicator(
              //     value: progress,
              //     minHeight: 8,
              //     borderRadius: BorderRadius.circular(4),
              //     color: progress < 0.3 ? Colors.red : Colors.green,
              //     backgroundColor: Theme.of(
              //       context,
              //     ).colorScheme.surfaceContainerHighest,
              //   ),
              // ] else ...[
              //   Text(
              //     status == PatientStatus.treated ? 'Treated' : 'Expired',
              //     style: TextStyle(
              //       fontSize: 14,
              //       color: status == PatientStatus.treated
              //           ? Colors.green
              //           : Colors.red,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              //   const SizedBox(height: 16),
              // ],
            ],
          ),
        ),
      ),
    );
  }
}
