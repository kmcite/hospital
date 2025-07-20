// // ignore_for_file: must_be_immutable

// import 'dart:async';

// import 'package:faker/faker.dart';
// import 'package:flutter/material.dart';
// import 'package:forui/forui.dart';
// import 'package:hospital/_archive/v2/v2.dart';
// import 'package:hospital/_archive/v4/staff.dart';

// final Clinic clinic = Clinic();

// class Clinic with ChangeNotifier {
//   Balance balance = Balance();
//   String name = 'GENERAL CLINIC';
//   int tokenCounter = 0;
//   List<Staff> staff = [];
//   List<Patient> patients = [];
//   Staff? current;
//   Clinic() {
//     _generatePatients();
//   }
//   FutureOr<void> _generatePatients() async {
//     while (true) {
//       final duration = Duration(
//         seconds: faker.randomGenerator.integer(20, min: 4),
//       );
//       patients.add(Patient());
//       notifyListeners();
//       await Future.delayed(duration);
//     }
//   }

//   void treat(Patient patient) {
//     patients.removeWhere((pt) => pt.name == patient.name);
//     balance.withdraw(400);
//     notifyListeners();
//   }

//   void hire(Staff staff) {
//     this.staff.add(staff);
//     balance.withdraw(staff.salary);
//     notifyListeners();
//   }

//   void fire(Staff staff) {
//     this.staff.removeWhere((_staff) => _staff.id == staff.id);
//     notifyListeners();
//   }

//   Widget build(BuildContext context) {
//     return ListenableBuilder(
//       listenable: this,
//       builder: (_, __) => FScaffold(
//         header: FHeader(
//           title: name.text(),
//         ),
//         footer: FBottomNavigationBar(
//           children: [
//             FBottomNavigationBarItem(
//               icon: Icon(FIcons.aArrowDown),
//               label: 'label'.text(),
//             ),
//           ],
//         ),
//         child: ListView(
//           children: [
//             balance,
//             FBadge(child: Text('staff')).pad(),
//             for (final staff in staff) staff.build(context),
//             FBadge(child: Text('patients')).pad(),
//             for (final patient in patients) patient.build(context),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Balance extends StatelessWidget with ChangeNotifier {
//   List<int> history = [150000];
//   int get balance => history.reduce((prev, next) => prev + next);
//   void withdraw(int amount) {
//     history.add(-amount);
//     notifyListeners();
//   }

//   void deposit(int amount) {
//     history.add(amount);
//     notifyListeners();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListenableBuilder(
//       listenable: this,
//       builder: (context, s) {
//         return FHeader(
//           title: balance.text(),
//         );
//       },
//     );
//   }
// }

// class Patient extends StatelessWidget with ChangeNotifier {
//   String name = faker.person.name();
//   String symptoms = faker.lorem.sentence();
//   @override
//   Widget build(BuildContext context) {
//     return ListenableBuilder(
//       listenable: this,
//       builder: (_, __) => FTile(
//         title: name.text(),
//         subtitle: symptoms.text(),
//         suffix: FButton.icon(
//           onPress: () => clinic.treat(this),
//           child: const Icon(FIcons.aArrowUp),
//         ),
//       ),
//     );
//   }
// }
