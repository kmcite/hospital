import 'dart:math';

import 'package:hospital/hospital/patients/symptom.dart';
import 'package:hospital/main.dart';

enum Status {
  waiting,
  discharged,
  death,
  refered,
  admitted;
}

enum Urgency { Stable, Critical, LifeThreatening }

@Entity()
class Patient {
  @Id(assignable: true)
  int id = 0;
  String symptom = _generateSymptom();
  late int admissionTime = _generateAdmissionTime(isEmergency);
  int remainingTime = 15;
  bool isEmergency = false;
  bool canPay = true;
  double satisfaction = 1;

  String name = "Unknown";
  int timeRequired = 10; // Time needed for treatment in minutes
  Urgency urgency = Urgency.Stable;
  bool isAdmitted = false;
  bool isAlive = true;

  void treat(int timeSpent) {
    remainingTime -= timeSpent;
    if (remainingTime <= 0) remainingTime = 0;
  }

  bool get needsUrgentCare =>
      urgency == Urgency.LifeThreatening && remainingTime < 5;

  String get status {
    if (remainingTime <= 0) {
      return Status.discharged.name;
    } else if (remainingTime <= 5) {
      return Status.refered.name;
    } else if (remainingTime <= 10) {
      return Status.admitted.name;
    } else {
      return Status.waiting.name;
    }
  }

  void updateStatus() {}

  List<String> investigations = [];
}

String _generateSymptom() {
  final symptoms = [
    "Fever",
    "Cough",
    "Headache",
    "Stomachache",
    "Fracture",
    "Heart Attack",
    "Allergic Reaction",
    "Burn",
    "Asthma Attack",
    "Infection",
    ...symptomsRepository.getStringsFor(),
  ];
  return symptoms[Random().nextInt(symptoms.length)];
}

int _generateAdmissionTime(bool isEmergency) {
  int baseTime = Random().nextInt(11) + 5;
  return isEmergency ? (baseTime / 1.5).round() : baseTime;
}

extension PatientExtensions on Patient {
  int calculateBill() {
    return admissionTime * 100;
  }

  List<String> determineInvestigations() {
    final investigations = <String>[];
    if (symptom == 'Heart Attack') {
      investigations.addAll(['ECG', 'Blood Test']);
    } else if (symptom == 'Fracture') {
      investigations.add('X-Ray');
    }
    return investigations;
  }
}

class PatientsRepository with CRUD<Patient> {}

final PatientsRepository patientsRepository = PatientsRepository();
