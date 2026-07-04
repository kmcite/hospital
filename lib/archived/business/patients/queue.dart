// part of '../patients.dart';

// void updatePatientQueue() {
//   patientQueueTick.value++;
//   removeExpiredWaitingPatients();
// }

// void removeExpiredWaitingPatients() {
//   final now = DateTime.now();
//   final expired = waitingPatients
//       .where((patient) => now.difference(patient.arrivedAt) >= patientWaitLimit)
//       .toList();

//   for (final patient in expired) {
//     waitingPatients.remove(patient);
//   }

//   if (expired.isNotEmpty) {
//     for (final patient in expired) {
//       ignoredPatients.add(patient);
//     }
//     abandonedPatientCount.value += expired.length;
//   }
// }

// Duration remainingWaitFor(Patient patient) {
//   final waited = DateTime.now().difference(patient.arrivedAt);
//   final remaining = patientWaitLimit - waited;

//   if (remaining.isNegative) return Duration.zero;
//   return remaining;
// }

// void callNextPatient() {
//   removeExpiredWaitingPatients();
//   if (!isDoctorRoomFunctional() ||
//       activePatient() != null ||
//       waitingPatients.isEmpty) {
//     return;
//   }

//   final patient = waitingPatients.first;
//   selectWaitingPatient(patient);
// }

// void selectWaitingPatient(Patient patient) {
//   removeExpiredWaitingPatients();
//   if (!isDoctorRoomFunctional() ||
//       activePatient() != null ||
//       !waitingPatients.contains(patient)) {
//     return;
//   }

//   waitingPatients.remove(patient);
//   activePatient.set(patient);
// }
