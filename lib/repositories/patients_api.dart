import 'package:hospital/main.dart';

import '../models/reception.dart';
import '../models/patient.dart';

/// what do you think of adding this to every patient
/// it may increase time complexity
final patientFees = signal(400.0);
final patientReferalFees = signal(100.0);
final referredPatients = mapSignal<String, Patient>({});

// final patientsRepository = PatientsRepository();

class PatientsRepository {
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
}

final receptionistQueue = mapSignal<String, Patient>({});
final receptions = mapSignal(<String, Reception>{});
final managedPatients = mapSignal(<String, Patient>{});
