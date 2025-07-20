// import 'dart:async';

// import 'package:copy_with_extension/copy_with_extension.dart';
// import 'patient.dart';
// import 'package:objectbox/objectbox.dart';

// part 'doctor.g.dart';

// @Entity()
// @CopyWith()
// class Doctor extends Stream<Doctor> {
//   @Id()
//   int id;
//   String name;
//   int price;
//   int statusIndex;
//   final patients = ToMany<Patient>();

//   Doctor({
//     this.id = 0,
//     this.name = '',
//     this.price = 0,
//     this.statusIndex = 0,
//   });

//   DoctorStatus get status => DoctorStatus.values.elementAt(statusIndex);
//   set status(DoctorStatus value) {
//     statusIndex = value.index;
//   }

//   @override
//   StreamSubscription<Doctor> listen(
//     void Function(Doctor event)? onData, {
//     Function? onError,
//     void Function()? onDone,
//     bool? cancelOnError,
//   }) {
//     return this.listen(
//       onData,
//       onError: onError,
//       onDone: onDone,
//       cancelOnError: cancelOnError,
//     );
//   }
// }

// enum DoctorStatus { onDuty, onLeave, availableForHire }
