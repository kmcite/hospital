import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:objectbox/objectbox.dart';

part 'patient.g.dart';

@Entity()
@CopyWith()
class Patient {
  @Id(assignable: true)
  int id;
  String name;
  int admissionTime;
  int remainingTime;
  bool canPay;
  double satisfaction;
  Urgency urgency;
  int statusIndex;
  Patient({
    this.id = 0,
    this.name = '',
    this.admissionTime = 0,
    this.remainingTime = 0,
    this.canPay = true,
    this.satisfaction = 1,
    this.urgency = Urgency.stable,
    this.statusIndex = 0,
  });

  // final doctor = ToOne<Doctor>();
  // final symptoms = ToMany<Symptom>();
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
}

enum Urgency { stable, critical, lifeThreatening }

enum Status { waiting, discharged, admitted, referred }
