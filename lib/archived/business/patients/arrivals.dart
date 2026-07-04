// part of '../patients.dart';

// void startPatientArrivals() {
//   if (_patientArrivalTimer != null || _patientQueueTimer != null) return;

//   admitWalkInPatient();
//   admitWalkInPatient();

//   _patientArrivalTimer = Timer.periodic(
//     const Duration(seconds: 12),
//     (_) => admitWalkInPatient(),
//   );

//   _patientQueueTimer = Timer.periodic(
//     const Duration(seconds: 1),
//     (_) => updatePatientQueue(),
//   );
// }

// void admitWalkInPatient() {
//   final patient = Patient();

//   if (!isReceptionOpen()) {
//     ignoredPatients.add(patient);
//     missedReceptionPatientCount.value++;
//     return;
//   }

//   waitingPatients.add(patient);
// }
