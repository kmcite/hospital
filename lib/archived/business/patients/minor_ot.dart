// part of '../patients.dart';

// void callNextMinorOtPatient() {
//   if (activeMinorOtPatient() != null || minorOtPatients.isEmpty) return;

//   final patient = minorOtPatients.first;
//   minorOtPatients.remove(patient);
//   activeMinorOtPatient.set(patient);
// }

// void selectMinorOtPatient(Patient patient) {
//   if (activeMinorOtPatient() != null || !minorOtPatients.contains(patient)) {
//     return;
//   }

//   minorOtPatients.remove(patient);
//   activeMinorOtPatient.set(patient);
// }

// void dischargeMinorOtPatient() {
//   final patient = activeMinorOtPatient();
//   if (patient == null) return;

//   minorOtDischargedPatients.add(patient);
//   minorOtTreatedPatientCount.value++;
//   earnMoney(patient.fee);
//   activeMinorOtPatient.set(null);
// }
