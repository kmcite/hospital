// part of '../patients.dart';

// void callNextWardPatient() {
//   if (!isWardFunctional() ||
//       activeWardPatient() != null ||
//       wardReferralPatients.isEmpty) {
//     return;
//   }

//   final patient = wardReferralPatients.first;
//   wardReferralPatients.remove(patient);
//   activeWardPatient.set(patient);
// }

// void selectWardPatient(Patient patient) {
//   if (!isWardFunctional() ||
//       activeWardPatient() != null ||
//       !wardReferralPatients.contains(patient)) {
//     return;
//   }

//   wardReferralPatients.remove(patient);
//   activeWardPatient.set(patient);
// }

// void dischargeWardPatient() {
//   final patient = activeWardPatient();
//   if (patient == null || !isWardFunctional()) return;

//   wardDischargedPatients.add(patient);
//   wardTreatedPatientCount.value++;
//   earnMoney(patient.fee * 0.75, 'Ward nursing care', 'Care');
//   activeWardPatient.set(null);
// }
