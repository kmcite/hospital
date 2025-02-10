import 'package:hospital/hospital/upgrades/upgrades.dart';

import '../patients/flow_repository.dart';
import '../patients/patient.dart';

class Resources {
  int hospitalFunds = 10000;
  int charityFunds = 5000;
  int availableBeds = 20;
  int staffCount = 10;

  bool canAfford(int cost) => hospitalFunds >= cost;

  void deductFunds(int cost) {
    if (!canAfford(cost)) throw Exception("Insufficient funds!");
    hospitalFunds -= cost;
  }

  void addFunds(int amount) => hospitalFunds += amount;
}

class EmergencySystem {
  int lawsuits = 0;

  void evaluatePatient(Patient patient) {
    if (!patient.isAlive || patient.needsUrgentCare) {
      lawsuits++;
    }
  }

  void handleCriticalCases(List<Patient> patients) {
    for (var patient in patients) {
      if (patient.needsUrgentCare && !patient.isAlive) {
        lawsuits++;
      }
    }
  }
}

void inform() {
  // Initialize systems
  var resources = Resources();
  var patientFlow = PatientFlow();
  var upgradeSystem = UpgradeSystem();

  // Add a new patient
  var newPatient = Patient()
    ..name = "John Doe"
    ..urgency = Urgency.Critical
    ..timeRequired = 15
    ..remainingTime = 15;

  patientFlow.addPatient(newPatient);

  // Admit patient
  patientFlow.admitPatient(resources);

  // Treat patient
  if (patientFlow.admittedPatients.isNotEmpty) {
    var patient = patientFlow.admittedPatients[0];
    patient.treat(5); // Spend 5 minutes treating the patient
    if (patient.remainingTime == 0) {
      patientFlow.dischargePatient(patient, resources);
    }
  }

  // Purchase upgrade
  var bedExpansion = Upgrade()
    ..name = "Bed Expansion"
    ..cost = 5000
    ..benefit = 5;

  upgradeSystem.addUpgrade(bedExpansion);
  upgradeSystem.applyUpgrade(bedExpansion, resources);

  print("Available Beds: ${resources.availableBeds}");
  print("Hospital Funds: ${resources.hospitalFunds}");
}
