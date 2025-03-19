import 'package:hospital/domain/models/patient.dart';

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
    // if (!patient.isAlive || patient.needsUrgentCare) {
    //   lawsuits++;
    // }
  }

  void handleCriticalCases(List<Patient> patients) {
    // for (var patient in patients) {
    //   // if (patient.needsUrgentCare && !patient.isAlive) {
    //   //   lawsuits++;
    //   // }
    // }
  }
}
