// import 'dart:math';

// import 'package:copy_with_extension/copy_with_extension.dart';
// import 'package:objectbox/objectbox.dart';

// @Entity()
// @CopyWith()
// class StaffMember {
//   @Id(assignable: true)
//   int id;
//   final String name;
//   final String role;
//   final int salary;
//   final double efficiency;
//   final double quality;

//   StaffMember({
//     this.id = 0,
//     required this.name,
//     required this.role,
//     required this.salary,
//     required this.efficiency,
//     required this.quality,
//   });

//   factory StaffMember.generateStaff(String role) {
//     final names = ["Dr. Smith", "Nurse Adams", "Dr. Gupta", "Nurse Lee"];
//     final name = names[Random().nextInt(names.length)];
//     int salary = role == "Doctor" ? 1000 : 500;
//     double efficiency = role == "Doctor" ? 1.2 : 1.1;
//     double quality = role == "Doctor" ? 1.1 : 1.05;
//     return StaffMember(
//       name: name,
//       role: role,
//       salary: salary,
//       efficiency: efficiency,
//       quality: quality,
//     );
//   }
// }
