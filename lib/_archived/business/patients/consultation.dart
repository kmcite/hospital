// part of '../patients.dart';

// void dischargeActivePatientHome() {
//   final patient = activePatient();
//   if (patient == null || !isDoctorRoomFunctional()) return;

//   homeDischargedPatients.add(patient);
//   completeActiveConsultation(patient);
// }

// void referActivePatientToMinorOt() {
//   final patient = activePatient();
//   if (patient == null || !isDoctorRoomFunctional()) return;

//   minorOtPatients.add(patient);
//   completeActiveConsultation(patient);
// }

// void referActivePatientToOpd() {
//   final patient = activePatient();
//   if (patient == null || !isDoctorRoomFunctional()) return;

//   opdReferralPatients.add(patient);
//   completeActiveConsultation(patient);
// }

// void referActivePatientToWard() {
//   final patient = activePatient();
//   if (patient == null || !isDoctorRoomFunctional()) return;

//   wardReferralPatients.add(patient);
//   completeActiveConsultation(patient);
// }

// void referActivePatientToBkmc() {
//   final patient = activePatient();
//   if (patient == null || !isDoctorRoomFunctional()) return;

//   externalReferralPatients.add(patient);
//   completeActiveConsultation(patient);
// }

// void completeActiveConsultation(Patient patient) {
//   consultedPatientCount.value++;
//   earnMoney(patient.fee);
//   activePatient.set(null);
// }
