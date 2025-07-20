// import 'package:flutter/material.dart';
// import 'package:forui/forui.dart';
// import 'package:hospital/domain/repositories/patients_repository.dart';
// import 'package:hospital/domain/repositories/settings_repository.dart';
// import 'package:hospital/main.dart';
// import 'package:hospital/domain/models/patient.dart';
// import 'package:hospital/navigator.dart';
// import 'package:hospital/ui/admitted/admitted_patients_page.dart';
// import 'waiting_patient_page.dart';

// mixin WaitingPatientsBloc {
//   Iterable<Patient> get patients => patientsRepository().where(
//         (patient) {
//           return patient.status == Status.waiting;
//         },
//       );
//   final beds = settingsRepository.beds;
//   final funds = settingsRepository.funds;
//   final charity = settingsRepository.charity;
//   final waitingBeds = settingsRepository.waitingBeds;
//   final settings = settingsRepository.settings;

//   final remove = patientsRepository.remove;
//   final put = patientsRepository.put;

//   bool admit(Patient patient) {
//     if (beds() == 0) {
//       return false; // No beds available
//     }

//     // Check if the patient can pay for the treatment
//     if (patient.canPay) {
//       // If the patient can pay, check if they have enough funds
//       if (funds() < 10) {
//         return false; // Not enough funds
//       }
//       settings(settings()..funds = funds() - 10); // Deduct funds
//     } else {
//       // If the patient can't pay, check if charity funds are available
//       if (charity() < 10) {
//         return false; // Not enough charity funds
//       }
//       settings(settings()..charity = charity() - 10); // Deduct charity funds
//     }
//     settings(settings()..beds = beds() - 1);
//     put(patient..status = Status.admitted);
//     return true;
//   }

//   void refer(Patient patient) {
//     settings(settings()..funds = funds() - 10); // Deduct funds
//     put(patient..status = Status.referred);
//   }

//   void discharge(Patient patient) {
//     put(patient..status = Status.discharged);
//   }

//   Injected<Patient> get patient => selectedPatientRepository;

//   void details(Patient _patient) {
//     patient.state = (_patient);
//     navigator.to(WaitingPatientPage());
//   }
// }

// class WaitingPatientsPage extends UI with WaitingPatientsBloc {
//   @override
//   Widget build(BuildContext context) {
//     return FScaffold(
//       header: FHeader(
//         title: const Text('Waiting Patients'),
//         // prefixes: [
//         //   FButton.icon(
//         //     child: Icon(FIcons.arrowLeft),
//         //     onPress: () => navigator.back(),
//         //   ),
//         // ],
//       ),
//       child: FTileGroup.builder(
//         count: patients.length,
//         tileBuilder: (context, index) {
//           final patient = patients.elementAt(index);
//           return PatientTile(
//             patient: patient,
//             onAdmit: () {
//               // if (!admit(patient)) {
//               //   ScaffoldMessenger.of(context).showSnackBar(
//               //     const SnackBar(
//               //       content: Text('No beds available'),
//               //       backgroundColor: Colors.red,
//               //     ),
//               //   );
//               // }
//               admit(patient);
//             },
//             onDischarge: () => discharge(patient),
//             onRefer: () => refer(patient),
//           );
//         },
//       ),
//     );
//   }
// }

// class PatientTile extends StatelessWidget {
//   final Patient patient;
//   final VoidCallback onAdmit;
//   final VoidCallback onDischarge;
//   final VoidCallback onRefer;

//   const PatientTile({
//     required this.patient,
//     required this.onAdmit,
//     required this.onDischarge,
//     required this.onRefer,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return FTile(
//       title: patient.name.text(),
//       subtitle: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               UrgencyIndicator(urgency: patient.urgency),
//               const SizedBox(width: 8),
//               Icon(
//                 patient.canPay ? Icons.attach_money : Icons.money_off,
//                 size: 16,
//                 color: patient.canPay ? Colors.green : Colors.red,
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 'Wait: ${patient.remainingTime}m',
//                 style: theme.textTheme.labelLarge,
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           ActionButtons(
//             onAdmit: onAdmit,
//             onDischarge: onDischarge,
//             onRefer: onRefer,
//           ),
//           const SizedBox(height: 8),
//           FProgress(value: patient.satisfaction / 100),
//           Text(
//             'Satisfaction: ${patient.satisfaction.toStringAsFixed(0)}%',
//             style: TextStyle(
//               fontSize: 12,
//               color: patient.satisfaction > 70
//                   ? Colors.green
//                   : patient.satisfaction > 40
//                       ? Colors.orange
//                       : Colors.red,
//             ),
//             textAlign: TextAlign.end,
//           ),
//         ],
//       ),
//       suffix:
//           patient.canPay ? Icon(FIcons.dollarSign) : Icon(FIcons.circleAlert),
//     );
//   }
// }

// class UrgencyIndicator extends StatelessWidget {
//   final Urgency urgency;

//   const UrgencyIndicator({required this.urgency, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final color = urgency == Urgency.lifeThreatening
//         ? Colors.red
//         : urgency == Urgency.critical
//             ? Colors.orange
//             : Colors.green;

//     final icon = urgency == Urgency.lifeThreatening
//         ? Icons.emergency
//         : urgency == Urgency.critical
//             ? Icons.warning
//             : Icons.info;

//     return Row(
//       children: [
//         Icon(icon, size: 16, color: color),
//         const SizedBox(width: 4),
//         Text(
//           urgency.toString().split('.').last,
//           style: TextStyle(color: color, fontSize: 12),
//         ),
//       ],
//     );
//   }
// }

// class ActionButtons extends StatelessWidget {
//   final VoidCallback onAdmit;
//   final VoidCallback onDischarge;
//   final VoidCallback onRefer;

//   const ActionButtons({
//     required this.onAdmit,
//     required this.onDischarge,
//     required this.onRefer,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: FButton.icon(
//             onPress: onAdmit,
//             child: Tooltip(
//               message: 'Admit Patient',
//               child: Icon(FIcons.plus),
//             ),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Expanded(
//           child: FButton.icon(
//             onPress: onDischarge,
//             child: Tooltip(
//               message: 'Discharge Patient',
//               child: Icon(FIcons.check),
//             ),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Expanded(
//           child: FButton.icon(
//             onPress: onRefer,
//             child: Tooltip(
//               message: 'Refer Patient',
//               child: Icon(FIcons.folderClosed),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
