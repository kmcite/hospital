import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hospital/domain/models/patient.dart';
import 'package:objectbox/objectbox.dart';

part 'doctor.g.dart';

@Entity()
@CopyWith()
class Doctor {
  @Id(assignable: true)
  final int? id;
  int price;
  String name;
  // @Backlink('doctor')
  final patients = ToMany<Patient>();

  int statusIndex = 0;
  Doctor({
    this.id,
    this.name = '',
    this.price = 40,
    this.statusIndex = 0,
  });
  @Transient()
  DoctorStatus get status => DoctorStatus.values.elementAt(statusIndex);
  @Transient()
  set status(DoctorStatus value) => statusIndex = value.index;
}

enum DoctorStatus { onLeave, onDuty, availableForHire }
