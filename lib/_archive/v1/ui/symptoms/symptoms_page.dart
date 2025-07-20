// import 'package:flutter/material.dart';
// import 'package:forui/forui.dart';
// import 'package:hospital/main.dart';
// import 'package:hospital/domain/models/symptom.dart';
// import 'package:hospital/navigator.dart';
// import 'package:hospital/domain/repositories/symptoms_repository.dart';
// import 'symptom_updater.dart';

// final selectedSymptomRepository = RM.inject(() => Symptom());

// mixin SymptomsBloc {
//   Injected<Symptom> get symptom => selectedSymptomRepository;
//   final symptoms = symptomsRepository;
// }

// // ignore: must_be_immutable
// class SymptomsPage extends UI with SymptomsBloc {
//   @override
//   Widget build(context) {
//     return FScaffold(
//       header: FHeader.nested(
//         title: const Text('Symptoms'),
//         prefixes: [
//           FButton.icon(
//             onPress: navigator.back,
//             child: Icon(FIcons.arrowLeft),
//           ),
//         ],
//         suffixes: [
//           FButton.icon(
//             onPress: () {
//               symptom.state = Symptom();
//               navigator.toDialog(const SymptomUpdaterDialog());
//             },
//             child: Icon(FIcons.plus),
//           ),
//         ],
//       ),
//       child: ListView.builder(
//         itemCount: symptomsRepository.getAll().length,
//         itemBuilder: (context, index) {
//           final _symptom = symptoms().elementAt(index);
//           return FTile(
//             title: Text(_symptom.name),
//             subtitle: Text(_symptom.description),
//             suffix: FBadge(
//               child: Text('\$${_symptom.cost}'),
//             ),
//             onPress: () {
//               symptom.state = (_symptom);
//               navigator.toDialog(const SymptomUpdaterDialog());
//             },
//           );
//         },
//       ),
//     );
//   }
// }
