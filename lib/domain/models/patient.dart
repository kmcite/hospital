import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hospital/main.dart';

import 'doctor.dart';
import 'symptom.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Patient extends Model with ChangeNotifier {
  @Id()
  int id;
  String name;
  int admissionTime;
  int remainingTime;
  bool canPay;
  double satisfaction;
  Urgency urgency;
  int statusIndex;
  final doctor = ToOne<Doctor>();
  final symptoms = ToMany<Symptom>();
  Timer? timer;
  Patient({
    this.id = 0,
    this.name = '',
    this.admissionTime = 0,
    this.remainingTime = 30,
    this.canPay = true,
    this.satisfaction = 1,
    this.urgency = Urgency.stable,
    this.statusIndex = 0,
  }) {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (remainingTime > 0) {
          remainingTime--;
          satisfaction -= 0.01;
        } else {
          timer.cancel();
          status = Status.discharged;
        }
        if (satisfaction < 0) {
          satisfaction = 0;
          status = Status.discharged;
        }
        notifyListeners();
        // patientsRepository(this);
      },
    );
  }

  Status get status => Status.values.elementAt(statusIndex);
  set status(Status value) {
    statusIndex = value.index;
  }

  @override
  String toString() {
    return 'Patient{'
        'id: $id, '
        'name: $name, '
        'admissionTime: $admissionTime, '
        'remainingTime: $remainingTime, '
        'canPay: $canPay, '
        'satisfaction: $satisfaction, '
        'urgency: $urgency, '
        'status: $status, '
        // 'symptoms: ${symptoms.map((s) => s.toString()).toList()}' // Include symptoms in toString
        '}';
  }

  dispose() {
    timer?.cancel();
    super.dispose();
  }
}

enum Urgency { stable, critical, lifeThreatening }

enum Status { waiting, discharged, admitted, referred }
