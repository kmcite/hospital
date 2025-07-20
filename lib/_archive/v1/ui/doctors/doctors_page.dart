// // import 'package:faker/faker.dart';
// import 'package:flutter/material.dart';
// import 'package:forui/forui.dart';
// import 'package:hospital/domain/repositories/doctors.dart';
// import 'package:hospital/main.dart';
// import 'package:hospital/domain/models/doctor.dart';

// final doctorsRM = RM.injectStream(
//   doctorsRepository.watch,
//   initialState: doctorsRepository(),
// );

// final _put = doctorsRepository.call;

// class DoctorsPage extends UI {
//   const DoctorsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FScaffold(
//       header: FHeader.nested(
//         title: 'DOCTORS'.text(),
//         suffixes: [
//           FButton.icon(
//             child: Icon(FIcons.plus),
//             onPress: () {
//               // _put(Doctor()..name = faker.person.name());
//             },
//           )
//         ],
//       ),
//       child: FTileGroup.builder(
//         label: 'doctors'.text(),
//         count: doctorsRM.state.length,
//         tileBuilder: (context, index) => FTile(
//           title: doctorsRM.state[index].name.text(),
//           subtitle: doctorsRM.state[index].status.text(),
//           suffix: Icon(FIcons.arrowRight),
//           onPress: () {},
//         ),
//       ),
//     );
//   }
// }
