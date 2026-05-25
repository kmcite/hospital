import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital/api/models.dart';
import 'package:hospital/api/patient.dart';

class PatientsBloc extends Cubit<Map<String, Patient>> {
  PatientsBloc() : super({});
  Patient create() {
    final patient = Patient();
    log("patient created: $patient");
    final copy = state..[patient.id] = patient;
    emit(copy);
    return patient;
  }

  void remove(Patient patient) {
    final copy = state..remove(patient.id);
    emit(copy);
  }
}

// final isGameRunning = ValueNotifier(false);
// final spawnTimer = ValueNotifier<double>(1.0);
// final maxSpawnTimer = ValueNotifier<double>(1.0);
// final isSpawnDelay = ValueNotifier<bool>(false);

// Timer? gameTickTimer;
// int patientId = 0;

// void stopGameLogic() {
//   gameTickTimer?.cancel();
//   gameTickTimer = null;
// }

// void startGameLogic() {
//   // patients.value.clear();
//   // treatedPatients.value.clear();
//   // expiredPatients.value.clear();
//   patientId = 0;

//   isGameRunning.value = true;
//   isSpawnDelay.value = false;
//   spawnTimer.value = 1.0;
//   maxSpawnTimer.value = 1.0;

//   gameTickTimer?.cancel();
//   gameTickTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
//     if (!isGameRunning.value) return;

//     // decrease wait timer and spawn
//     spawnTimer.value -= 0.1;

//     // Fix for Hot Reload desync: if we added maxSpawnTimer while spawnTimer > 1.0
//     if (spawnTimer.value > maxSpawnTimer.value) {
//       maxSpawnTimer.value = spawnTimer.value;
//     }

//     if (spawnTimer.value <= 0) {
//       if (isSpawnDelay.value) {
//         isSpawnDelay.value = false;
//         final nextSpawnTime =
//             20.0 + Random().nextDouble() * 20.0; // reset (20-40 seconds)
//         spawnTimer.value = nextSpawnTime;
//         maxSpawnTimer.value = nextSpawnTime;
//       } else {
//         // final randomTime =
//         //     30.0 + Random().nextDouble() * 90.0; // expiry (30-120 seconds)
//         // final idToAssign = ++patientId;
//         // final condition = allConditions[Random().nextInt(allConditions.length)];
//         // final name = (listOfNames..shuffle()).first;

//         // final newPatient = Patient(
//         //   idToAssign,
//         //   name,
//         //   randomTime,
//         //   condition,
//         // );

//         // patients.value.add(newPatient);
//         log('Patient spawned', name: 'GAME_LOGIC');

//         isSpawnDelay.value = true;
//         spawnTimer.value = 4.0;
//         maxSpawnTimer.value = 4.0;
//       }
//     }

//     // tick active patients
//     // final toRemove = <Patient>[];
//     // for (var p in patients.value) {
//     //   if (p.status.value == PatientStatus.waiting) {
//     //     p.remainingTime.value -= 0.1;
//     //     if (p.remainingTime.value <= 0) {
//     //       p.status.value = PatientStatus.expired;
//     //       toRemove.add(p);
//     //       expiredPatients.value.add(p);
//     //       log('Patient expired: ${p.name}', name: 'GAME_LOGIC');

//     //       if (p.isDialogOpen) {
//     //         navigateBack();
//     //         p.isDialogOpen = false;
//     //       }
//     //     }
//     //   } else if (p.status.value == PatientStatus.treated) {
//     //     toRemove.add(p);
//     //     treatedPatients.value.add(p);
//     //   }
//     // }

//     // for (var p in toRemove) {
//     //   patients.value.remove(p);
//     // }
//   });
// }
