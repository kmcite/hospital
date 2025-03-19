import 'package:objectbox/objectbox.dart';

@Entity()
class Patient {
  @Id()
  int id = 0;
  String name = '';
  String symptom = '';
  int admissionTime = 0;
  int remainingTime = 0;
  bool isEmergency = true;
  bool canPay = true;
  double satisfaction = 1;
  Urgency urgency = Urgency.stable;
  bool isAdmitted = true;
  bool isAlive = true;
  Status status = Status.waiting;
  List<String> investigations = [];
}

enum Urgency { stable, critical, lifeThreatening }

enum Status { waiting, discharged, admitted, referred }
