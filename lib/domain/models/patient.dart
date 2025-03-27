import 'package:hospital/domain/models/doctor.dart';
import 'package:hospital/domain/models/symptom.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Patient {
  @Id()
  int id = 0;
  String name = '';
  int admissionTime = 0;
  int remainingTime = 0;
  bool canPay = true;
  double satisfaction = 1;
  Urgency urgency = Urgency.stable;

  int statusIndex = 0;

  final doctor = ToOne<Doctor>();
  final symptoms = ToMany<Symptom>();
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
        'symptoms: ${symptoms.map((s) => s.toString()).toList()}' // Include symptoms in toString
        '}';
  }
}

enum Urgency { stable, critical, lifeThreatening }

enum Status { waiting, discharged, admitted, referred }
