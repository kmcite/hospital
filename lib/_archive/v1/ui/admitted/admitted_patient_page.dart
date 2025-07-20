// // ignore_for_file: unused_local_variable, unnecessary_null_comparison

// import 'package:flutter/material.dart';
// import 'package:hospital/domain/repositories/doctors.dart';
// import 'package:hospital/domain/repositories/patients_repository.dart';
// import 'package:hospital/main.dart';
// import 'package:hospital/domain/models/doctor.dart';
// import 'package:hospital/domain/models/patient.dart';
// import 'package:hospital/navigator.dart';

// mixin AdmittedPatientBloc {
//   Iterable<Doctor> doctors = [];
//   Iterable<Patient> patients = [];
//   Patient patient = Patient();

//   final put = patientsRepository.put;

//   void refer() {
//     if (patient != null) {
//       put(patient..status = Status.referred);
//       back();
//     }
//   }

//   void discharge() {
//     if (patient != null) {
//       put(patient..status = Status.discharged);
//       back();
//     }
//   }

//   void back() {
//     navigator.back();
//   }

//   Iterable<Doctor> get availableDoctors =>
//       doctorsRepository.getDoctorsByStatus(DoctorStatus.onDuty);

//   void assignDoctor(Doctor doctor) {
//     // doctorsRepository.assignToPatient(doctor, patient());
//   }

//   void unassignDoctor() {
//     // if (patient().doctor.target != null) {
//     //   doctorsRepository.unassignFromPatient(
//     //       patient().doctor.target!, patient());
//     // }
//   }
// }

// // ignore: must_be_immutable
// class AdmittedPatientPage extends UI with AdmittedPatientBloc {
//   AdmittedPatientPage({super.key});
//   @override
//   Widget build(context) {
//     if (patient == null) {
//       return const Center(child: Text('No patient selected'));
//     }

//     final theme = Theme.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: navigator.back,
//         ),
//         title: Text(patient.name),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.receipt),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.close),
//             onPressed: () {},
//             style: IconButton.styleFrom(
//               foregroundColor: theme.colorScheme.error,
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: [
//                 Chip(label: Text('#${patient.id}')),
//                 Chip(label: Text(patient.name)),
//                 Chip(label: Text('Admitted: ${patient.admissionTime}')),
//                 Chip(label: Text('Remaining: ${patient.remainingTime}')),
//                 Chip(
//                   label: Text(patient.canPay ? 'Can Pay' : 'Cannot Pay'),
//                   backgroundColor: patient.canPay
//                       ? theme.colorScheme.secondaryContainer
//                       : theme.colorScheme.errorContainer,
//                 ),
//                 Chip(
//                   label: Text('${patient.satisfaction}% Satisfied'),
//                   backgroundColor: patient.satisfaction > 70
//                       ? Colors.green[100]
//                       : patient.satisfaction > 40
//                           ? Colors.orange[100]
//                           : Colors.red[100],
//                 ),
//                 Chip(
//                   label: Text(patient.urgency.toString()),
//                   backgroundColor: patient.urgency == Urgency.lifeThreatening
//                       ? Colors.red[100]
//                       : patient.urgency == Urgency.critical
//                           ? Colors.orange[100]
//                           : Colors.green[100],
//                 ),
//                 Chip(label: Text(patient.status.toString())),
//               ],
//             ),
//             const SizedBox(height: 24),
//             patient.doctor.target != null
//                 ? Card(
//                     child: ListTile(
//                       title: Text('Dr. ${patient.doctor.target!.name}'),
//                       subtitle: const Text('Assigned Doctor'),
//                       trailing: IconButton(
//                         icon: const Icon(Icons.person_remove),
//                         onPressed: () {},
//                         style: IconButton.styleFrom(
//                           foregroundColor: theme.colorScheme.error,
//                         ),
//                       ),
//                     ),
//                   )
//                 : const SizedBox.shrink(),
//             const SizedBox(height: 16),
//             Text(
//               'Available Doctors',
//               style: theme.textTheme.titleMedium,
//             ),
//             const SizedBox(height: 8),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: doctors.length,
//                 itemBuilder: (context, index) {
//                   final doctor = doctors.elementAt(index);
//                   return Card(
//                     margin: const EdgeInsets.symmetric(vertical: 4),
//                     child: ListTile(
//                       title: Text(doctor.name),
//                       subtitle: Text('On Duty'),
//                       trailing: IconButton(
//                         icon: const Icon(Icons.person_add),
//                         onPressed: () {
//                           // assignDoctor(doctor);
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
