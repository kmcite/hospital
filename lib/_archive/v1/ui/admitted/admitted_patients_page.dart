// import 'package:flutter/material.dart';
// import 'package:forui/forui.dart';
// import 'package:hospital/domain/repositories/patients_repository.dart';
// import 'package:hospital/domain/repositories/settings_repository.dart';
// import 'package:hospital/main.dart';
// import 'package:hospital/domain/models/patient.dart';
// import 'package:hospital/navigator.dart';
// import 'admitted_patient_page.dart';

// final selectedPatientRepository = RM.inject(() => Patient());

// final funds = settingsRepository.funds;

// void discharge(Patient patient) {
//   int amountToAddToFunds = 0;
//   for (var symptom in patient.symptoms) {
//     amountToAddToFunds += symptom.cost;
//   }

//   funds(funds() + amountToAddToFunds);
//   patient.status = Status.discharged;
//   patientsRepository.put(patient);
// }

// Iterable<Patient> get admittedPatients =>
//     patientsRepository().where((pt) => pt.status == Status.admitted);

// Injected<Patient> get selectPatient => selectedPatientRepository;

// void details(Patient patient) {
//   selectPatient.state = patient;
//   navigator.to(AdmittedPatientPage());
// }

// class AdmittedPatientsPage extends UI {
//   @override
//   Widget build(context) {
//     final theme = Theme.of(context);
//     return FScaffold(
//       header: FHeader(
//         // prefixes: [
//         //   FButton.icon(
//         //     child: const Icon(Icons.arrow_back),
//         //     onPress: navigator.back,
//         //   ),
//         // ],
//         title: const Text('Admissions'),
//         suffixes: [
//           // ScoreBadge(),
//           // FundsBadge(),
//           // CharityBadge(),
//         ],
//       ),
//       child: ListView.builder(
//         padding: const EdgeInsets.all(16.0),
//         itemCount: admittedPatients.length,
//         itemBuilder: (context, index) {
//           final patient = admittedPatients.elementAt(index);
//           return Card(
//             child: Column(
//               spacing: 8,
//               children: [
//                 '${patient.name}'.text(textScaleFactor: 2),
//                 ListenableBuilder(
//                   listenable: patient,
//                   builder: (context, child) => FProgress(
//                     value: patient.satisfaction,
//                   ),
//                 ),
//                 Icon(
//                   patient.canPay ? Icons.attach_money : Icons.money_off,
//                   size: 16,
//                   color: patient.canPay
//                       ? theme.colorScheme.primary
//                       : theme.colorScheme.error,
//                 ),
//                 FButton.icon(
//                   onPress: () => discharge(patient),
//                   child: Icon(FIcons.badgeDollarSign),
//                 ),
//               ],
//             ).pad(),
//           );

//           // ignore: dead_code
//           return Card(
//             child: ListTile(
//               title: Text(patient.name),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.timer,
//                         size: 16,
//                         color: theme.colorScheme.primary,
//                       ),
//                       const SizedBox(width: 4),
//                       Text('Remaining: ${patient.remainingTime}'),
//                       const SizedBox(width: 16),
//                       Icon(
//                         patient.canPay ? Icons.attach_money : Icons.money_off,
//                         size: 16,
//                         color: patient.canPay
//                             ? theme.colorScheme.primary
//                             : theme.colorScheme.error,
//                       ),
//                       const SizedBox(width: 4),
//                       Text(patient.canPay ? 'Can Pay' : 'Cannot Pay'),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   LinearProgressIndicator(
//                     value: patient.satisfaction / 100,
//                     backgroundColor: Colors.grey[200],
//                     valueColor: AlwaysStoppedAnimation<Color>(
//                       patient.satisfaction > 70
//                           ? Colors.green
//                           : patient.satisfaction > 40
//                               ? Colors.orange
//                               : Colors.red,
//                     ),
//                   ),
//                 ],
//               ),
//               trailing: IconButton(
//                 icon: const Icon(Icons.more_vert),
//                 onPressed: () => showModalBottomSheet(
//                   context: context,
//                   builder: (context) => Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       ListTile(
//                         leading: const Icon(Icons.info),
//                         title: const Text('View Details'),
//                         onTap: () {
//                           Navigator.pop(context);
//                           details(patient);
//                         },
//                       ),
//                       ListTile(
//                         leading: const Icon(Icons.check),
//                         title: const Text('Discharge'),
//                         onTap: () {
//                           Navigator.pop(context);
//                           discharge(patient);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
