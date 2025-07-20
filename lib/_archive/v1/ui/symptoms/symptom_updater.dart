// import 'package:flutter/material.dart';
// import 'package:forui/forui.dart';
// import 'package:hospital/main.dart';
// import 'package:hospital/domain/models/symptom.dart';
// import 'package:hospital/navigator.dart';
// import 'package:hospital/domain/repositories/symptoms_repository.dart';
// import 'package:hospital/ui/symptoms/symptoms_page.dart';

// mixin SymptomUpdaterBloc {
//   Symptom symptom([Symptom? value]) {
//     if (value != null) {
//       selectedSymptomRepository.state = value;
//     }
//     return selectedSymptomRepository.state;
//   }

//   void back() {
//     navigator.back();
//     symptom(Symptom());
//   }

//   void save() {
//     navigator.back();
//     symptomsRepository.put(symptom());
//   }
// }

// class SymptomUpdaterDialog extends UI with SymptomUpdaterBloc {
//   const SymptomUpdaterDialog();

//   @override
//   Widget build(context) {
//     return FDialog(
//       title: FHeader(
//         title: Text(symptom().name.isEmpty ? 'New Symptom' : symptom().name),
//         suffixes: [
//           FBadge(
//             child: Text(
//               '\$${symptom().cost}',
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           FTextField(
//             label: 'name'.text(),
//             initialText: symptom().name,
//             onChange: (value) => symptom(symptom()..name = value),
//           ),
//           FTextField(
//             label: 'description'.text(),
//             initialText: symptom().description,
//             onChange: (value) => symptom(symptom()..description = value),
//           ),
//           FLabel(
//             label: 'cost'.text(),
//             axis: Axis.vertical,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 FButton.icon(
//                   onPress: () {
//                     symptom(symptom()..cost = symptom().cost - 10);
//                   },
//                   child: Icon(FIcons.delete),
//                 ),
//                 Text(
//                   '\$${symptom().cost}',
//                 ).pad(),
//                 FButton.icon(
//                   onPress: () {
//                     symptom(symptom()..cost = symptom().cost + 10);
//                   },
//                   child: Icon(FIcons.plus),
//                 ),
//               ],
//             ).pad(),
//           ),
//         ],
//       ),
//       direction: Axis.horizontal,
//       actions: [
//         FButton(
//           onPress: save,
//           child: Text('Save'),
//         ),
//         FButton(
//           onPress: back,
//           style: FButtonStyle.destructive(),
//           child: Text('Cancel'),
//         ),
//       ],
//     );
//   }
// }
