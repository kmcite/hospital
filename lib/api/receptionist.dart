import 'dart:developer' show log;
import 'package:hospital/api/models.dart';

class Receptionist {
  final String name;
  final DateTime hiredDate;
  double efficiency;
  bool isOnDuty;
  bool isExhausted;
  int patientsServed;

  Receptionist({
    required this.id,
    required this.name,
    this.efficiency = 1.0,
    this.isExhausted = false,
    this.isOnDuty = false,
    this.patientsServed = 0,
    DateTime? hiredDate,
  }) : hiredDate = hiredDate ?? DateTime.now();

  void provideService() {
    if (isExhausted) return;

    patientsServed++;
    efficiency -= 0.005; // Slower degradation for better gameplay

    if (efficiency <= 0) {
      efficiency = 0;
      isExhausted = true;
      isOnDuty = false;
    }
  }

  void rest() {
    efficiency = 1.0;
    isExhausted = false;
  }

  double get efficiencyPercentage => efficiency * 100;

  bool get needsRest => efficiency < 0.3;

  String get status {
    if (isExhausted) return 'Exhausted';
    if (!isOnDuty) return 'Off Duty';
    if (needsRest) return 'Needs Rest';
    if (efficiency > 0.8) return 'Excellent';
    if (efficiency > 0.5) return 'Good';
    return 'Tiring';
  }

  int nextId = 1;

  final String id;
  Chit createChit(Patient patient) {
    final payment = patient.pay();
    log('patient paid chit fee');

    log('chit created for ${patient.name}');
    return Chit(
      nextId++,
      patient.name,
      DateTime.now(),
      payment,
    );
  }
}
