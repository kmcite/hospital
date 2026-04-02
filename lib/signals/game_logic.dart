import 'dart:async' show Timer;
import 'dart:developer' show log;
import 'dart:math' show Random;
import 'package:hospital/data/patient.dart';
import 'package:hospital/data/patient_names.dart';
import 'package:hospital/signals/patients.dart';
import 'package:hospital/signals/navigation.dart';
import 'package:hospital/data/medical_data.dart';
import 'package:signals/signals.dart';

final isGameRunning = signal(false);
final spawnTimer = signal<double>(1.0);
final maxSpawnTimer = signal<double>(1.0);
final isSpawnDelay = signal<bool>(false);

Timer? gameTickTimer;
int patientId = 0;

void stopGameLogic() {
  gameTickTimer?.cancel();
  gameTickTimer = null;
}

void startGameLogic() {
  patients.clear();
  treatedPatients.clear();
  expiredPatients.clear();
  patientId = 0;

  isGameRunning.value = true;
  isSpawnDelay.value = false;
  spawnTimer.value = 1.0;
  maxSpawnTimer.value = 1.0;

  gameTickTimer?.cancel();
  gameTickTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
    if (!isGameRunning()) return;

    // decrease wait timer and spawn
    spawnTimer.value -= 0.1;

    // Fix for Hot Reload desync: if we added maxSpawnTimer while spawnTimer > 1.0
    if (spawnTimer() > maxSpawnTimer()) {
      maxSpawnTimer.value = spawnTimer();
    }

    if (spawnTimer() <= 0) {
      if (isSpawnDelay()) {
        isSpawnDelay.value = false;
        final nextSpawnTime =
            20.0 + Random().nextDouble() * 20.0; // reset (20-40 seconds)
        spawnTimer.value = nextSpawnTime;
        maxSpawnTimer.value = nextSpawnTime;
      } else {
        final randomTime =
            30.0 + Random().nextDouble() * 90.0; // expiry (30-120 seconds)
        final idToAssign = ++patientId;
        final condition = allConditions[Random().nextInt(allConditions.length)];
        final name = (listOfNames..shuffle()).first;

        final newPatient = Patient(
          idToAssign,
          name,
          randomTime,
          condition,
        );

        patients.add(newPatient);
        log('Patient spawned', name: 'GAME_LOGIC');

        isSpawnDelay.value = true;
        spawnTimer.value = 4.0;
        maxSpawnTimer.value = 4.0;
      }
    }

    // tick active patients
    final toRemove = <Patient>[];
    for (var p in patients) {
      if (p.status() == PatientStatus.waiting) {
        p.remainingTime.value -= 0.1;
        if (p.remainingTime() <= 0) {
          p.status.value = PatientStatus.expired;
          toRemove.add(p);
          expiredPatients.add(p);
          log('Patient expired: ${p.name}', name: 'GAME_LOGIC');

          if (p.isDialogOpen) {
            navigateBack();
            p.isDialogOpen = false;
          }
        }
      } else if (p.status() == PatientStatus.treated) {
        toRemove.add(p);
        treatedPatients.add(p);
      }
    }

    for (var p in toRemove) {
      patients.remove(p);
    }
  });
}
