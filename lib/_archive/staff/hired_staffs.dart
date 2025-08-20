// import 'package:flutter/material.dart';
// import 'package:hospital/main.dart';
// import 'package:hospital/utils/list_view.dart';
// import 'package:hospital/v5/api/staff/staff.dart';
// import 'package:hospital/v5/api/staff/staff_api.dart';
// import 'package:hux/hux.dart';

// class HiredStaffs extends UI {
//   @override
//   Widget build(BuildContext context) {
//     return listView(
//       staffsRepository.hiredStaffs.values,
//       (staff) => ListTile(
//         title: staff.name.text(),
//         subtitle: staff.role.text(),
//         trailing: HuxButton(
//           // style: FButtonStyle.destructive(),
//           onPressed: () => fireStaff(staff),
//           child: Icon(FeatherIcons.filter),
//         ),
//       ),
//     );
//   }
// }

// void fireStaff(Staff staff) {
//   staffsRepository.hiredStaffs.remove(staff.id);
// }
