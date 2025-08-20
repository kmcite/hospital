// import 'package:hospital/main.dart';
// import '../../models/patient.dart';
// import '../../repositories/patient_generator_api.dart';
// import '../../repositories/patients_api.dart';
// import 'application.dart';

// void startPatientGeneration() async {
//   // subscribe(
//   //   patientGenerator().listen(
//   //     (generated) {
//   //       if (unsatidfiedPatients.length > 5) {
//   //         return;
//   //       }
//   //       if (generated.patient != null) {
//   //         receptionistQueue[generated.patient!.id] = generated.patient!;
//   //       } else {
//   //         remainingTimeForNext.set(generated.currentTimeRemainingForNext);
//   //         totalTimeForNext.set(generated.totalTimeRemainingForNext);
//   //       }
//   //     },
//   //   ),
//   // );
//   while (true) {
//     await Future.delayed(Duration(seconds: 1));
//     List<Patient> toBeRemoved = [];
//     for (final pt in receptionistQueue.values) {
//       if (!pt.isSatisfied()) {
//         toBeRemoved.add(pt);
//       }
//     }
//     for (final pt in toBeRemoved) {
//       receptionistQueue.remove(pt.id);
//       unsatidfiedPatients[pt.id] = pt;
//     }
//   }
// }

// final unsatidfiedPatients = mapSignal(<String, Patient>{});
