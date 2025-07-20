// import 'dart:async';
// import 'package:faker/faker.dart';
// import 'package:flutter/material.dart';
// import 'package:hospital/main.dart';
// import 'package:hospital/_archive/v3/clinic_bloc.dart';
// import 'package:hospital/_archive/v3/staff.dart';

// import 'dart:math';

// abstract class EmployeeState {
//   void hire(EmployeeContext context);
//   void fire(EmployeeContext context);
// }

// class AvailableState extends EmployeeState {
//   @override
//   void hire(EmployeeContext context) {
//     context.state = HiredState();
//     print('${context.name} has been hired!');
//   }

//   @override
//   void fire(EmployeeContext context) {
//     print('Cannot fire ${context.name}. Not yet hired.');
//   }
// }

// class HiredState extends EmployeeState {
//   @override
//   void hire(EmployeeContext context) {
//     print('${context.name} is already hired.');
//   }

//   @override
//   void fire(EmployeeContext context) {
//     context.state = FiredState();
//     print('${context.name} has been fired.');
//   }
// }

// class FiredState extends EmployeeState {
//   @override
//   void hire(EmployeeContext context) {
//     print('${context.name} has been fired. Rehire not allowed.');
//   }

//   @override
//   void fire(EmployeeContext context) {
//     print('${context.name} already fired.');
//   }
// }

// class EmployeeContext {
//   final String id;
//   final String name;
//   EmployeeState state;

//   EmployeeContext({
//     required this.id,
//     required this.name,
//     EmployeeState? initialState,
//   }) : state = initialState ?? AvailableState();

//   void hire() => state.hire(this);
//   void fire() => state.fire(this);
// }

// Stream<EmployeeContext> get randomCandidateStream async* {
//   final random = Random();

//   while (true) {
//     final delay = Duration(seconds: random.nextInt(17) + 4); // 4–20 sec
//     await Future.delayed(delay);

//     yield EmployeeContext(
//       id: faker.guid.guid(),
//       name: faker.person.name(),
//     );
//   }
// }

// final hiringManager = HiringManager();

// abstract class HiringState {
//   void handle(HiringContext context);
// }

// class HiringStateIdle extends HiringState {
//   @override
//   void handle(HiringContext context) {
//     throw UnimplementedError();
//   }
// }

// class HiringContext {
//   HiringState state;
//   HiringContext(this.state);
// }

// /// What should [HiringManager] do?
// ///
// /// 1. maintaing hirable staff
// /// 2. maintaing hired staff
// /// 3. awards of salaries
// /// 4. hire and fire staff, also maintain hirable when one is hired.
// class HiringManager extends ChangeNotifier {
//   HiringManager() : super() {
//     // every 30 seconds salary will be awarded to the staff
//     _nextStaff = watch().listen(
//       (staff) {
//         availableStaff.add(staff);
//         // Optionally notify listeners/UI here
//       },
//     );
//     awardSalariesToHiredStaff = Timer.periodic(
//       30.seconds,
//       (_) {
//         for (final staff in hiredStaff) {
//           clinic.balance = clinic.balance - staff.salary;
//           print('$staff awarded salary');
//         }
//         // Optionally notify listeners/UI here
//       },
//     );
//   }
//   StreamSubscription<Staff>? _nextStaff;
//   final List<Staff> hiredStaff = <Staff>[];
//   final List<Staff> availableStaff = <Staff>[];
//   Stream<Staff> watch() async* {
//     while (true) {
//       final yielder = switch (faker.randomGenerator.integer(2)) {
//         0 => Doctor(),
//         1 => Nurse(),
//         _ => Ota(),
//       };
//       yield yielder;
//       print(yielder.runtimeType);
//       final delay = faker.randomGenerator.integer(10, min: 5);
//       await Future.delayed(delay.seconds);
//     }
//   }

//   Timer? awardSalariesToHiredStaff;

//   void dispose() {
//     super.dispose();
//     // stop awarding salaries
//     awardSalariesToHiredStaff?.cancel();
//     _nextStaff?.cancel();
//   }

//   /// STAFF
//   Iterable<Doctor> get doctors => hiredStaff.whereType<Doctor>();
//   Iterable<Nurse> get nurses => hiredStaff.whereType<Nurse>();
//   Iterable<Ota> get otas => hiredStaff.whereType<Ota>();

//   void hire(Staff staff) {
//     clinic.balance = clinic.balance - staff.salary;
//     availableStaff.removeWhere((s) => s.id == staff.id);
//     hiredStaff.add(staff);
//     notifyListeners(); // Optionally replace with a callback if needed
//   }

//   void fire(Staff staff) {
//     hiredStaff.removeWhere((s) => s.id == staff.id);
//     notifyListeners(); // Optionally replace with a callback if needed
//   }
// }
