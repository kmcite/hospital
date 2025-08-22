import 'package:hospital/main.dart';

import '../models/patient.dart';
import 'generation_api.dart'; // Add this import

/// what do you think of adding this to every patient
/// it may increase time complexity
final patientFees = signal(400.0);
final patientReferalFees = signal(100.0);
final referredPatients = mapSignal<String, Patient>({});
final ambulanceFees = signal(100.0);

// Uncomment and activate PatientsRepository
final patientsRepository = PatientsRepository();

class PatientsRepository {
  PatientsRepository() {
    // Connect patient flow from generation to reception
    connectPatientFlow();
  }

  final waitingPatients = mapSignal<String, Patient>({});
  final managedPatients = mapSignal<String, Patient>({});

  void manage(Patient patient) {
    managedPatients[patient.id] = patient;
  }

  void wait(Patient patient) {
    waitingPatients[patient.id] = patient;
  }

  void refer(Patient pt) {
    waitingPatients.remove(pt.id);
    referredPatients[pt.id] = pt;
  }

  // Connect generation to reception flow
  void connectPatientFlow() async {
    while (true) {
      await Future.delayed(Duration(milliseconds: 500));

      // Move patients from generation to reception queue
      final generatedPatients =
          List<Patient>.from(generationRepository.waitingPatients.values);
      for (final patient in generatedPatients) {
        if (!receptionistQueue.containsKey(patient.id)) {
          receptionistQueue[patient.id] = patient;
          generationRepository.waitingPatients.remove(patient.id);
        }
      }
    }
  }

  // Add discharge functionality
  void discharge(Patient patient) {
    // Remove from all queues and collections
    managedPatients.remove(patient.id);
    waitingPatients.remove(patient.id);
    receptionistQueue.remove(patient.id);
    referredPatients.remove(patient.id);
  }
}

final receptionistQueue = mapSignal<String, Patient>({});
final managedPatients = mapSignal(<String, Patient>{});
