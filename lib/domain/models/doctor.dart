import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hospital/main.dart';
import 'patient.dart';
import 'package:objectbox/objectbox.dart';

part 'doctor.g.dart';

@Entity()
@CopyWith()
class Doctor extends Model {
  @Id()
  int id;
  String name;
  int price;
  int statusIndex;
  final patients = ToMany<Patient>();

  Doctor({
    this.id = 0,
    this.name = '',
    this.price = 0,
    this.statusIndex = 0,
  });

  DoctorStatus get status => DoctorStatus.values.elementAt(statusIndex);
  set status(DoctorStatus value) {
    statusIndex = value.index;
  }
}

enum DoctorStatus { onDuty, onLeave, availableForHire }
