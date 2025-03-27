import 'package:hospital/domain/api/faker.dart';
import 'package:hospital/domain/models/patient.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Doctor {
  @Id()
  int id = 0;
  int price = 80;
  String name = personFaker.name();
  @Backlink('doctor')
  final patients = ToMany<Patient>();

  int statusIndex = 0;
  DoctorStatus get status => DoctorStatus.values.elementAt(statusIndex);
  set status(DoctorStatus value) => statusIndex = value.index;
}

enum DoctorStatus { onLeave, onDuty, hired, availableForHire }
