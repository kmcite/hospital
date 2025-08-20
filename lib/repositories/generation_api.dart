import 'package:hospital/main.dart';

import '../models/patient.dart';

final generationRepository = GenerationRepository();

class GenerationRepository {
  GenerationRepository() {
    generator();
    autoRemoveUnsatisfied();
  }
  final unsatisfiedPatients = mapSignal<String, Patient>({});
  final waitingPatients = mapSignal<String, Patient>({});
  final currentRemainingTimeForNext = signal(0);
  final totalRemainingTimeForNext = signal(1);

  void generator() async {
    while (true) {
      final duration = faker.randomGenerator.integer(10, min: 5);
      totalRemainingTimeForNext.set(duration);
      currentRemainingTimeForNext.set(duration);
      while (currentRemainingTimeForNext() > 0) {
        await Future.delayed(Duration(seconds: 1));
        currentRemainingTimeForNext.value--;
      }
      final pt = Patient();
      waitingPatients[pt.id] = pt;
    }
  }

  void autoRemoveUnsatisfied() async {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      List<Patient> unsatisfied = [];
      for (var pt in waitingPatients.values) {
        if (!pt.isSatisfied()) {
          unsatisfied.add(pt);
        }
      }
      for (final pt in unsatisfied) {
        waitingPatients.remove(pt.id);
        unsatisfiedPatients[pt.id] = pt;
      }
    }
  }
}

// class PatientGenerator {
//   Patient? patient;
//   int currentTimeRemainingForNext = 0;
//   int totalTimeRemainingForNext = 1;
// }

// final remainingTimeForNext = signal(0);
// final totalTimeForNext = signal(1);

// Stream<PatientGenerator> patientGenerator() async* {
//   // print('[PatientGenerator] started');
//   while (true) {
//     int duration = faker.randomGenerator.integer(10, min: 5);
//     var pg = PatientGenerator()
//       ..totalTimeRemainingForNext = duration
//       ..currentTimeRemainingForNext = duration;
//     // print('[TotalTimeForNextPatientThisTime] $duration');
//     while (duration > 0) {
//       await Future.delayed(Duration(seconds: 1));
//       duration--;
//       // print('[RemainingTimeForNextPatient] ${duration}');
//       yield pg
//         ..currentTimeRemainingForNext = duration
//         ..patient = null;
//     }
//     // await Future.delayed(Duration(seconds: 1));
//     yield pg..patient = Patient();
//   }
// }
