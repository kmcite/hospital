// import 'package:flutter/material.dart';
// import 'package:hospital/main.dart';
// import 'package:hospital/utils/list_view.dart';
// import 'package:hospital/v5/api/balance_api.dart';
// import 'package:hospital/v5/api/receipt.dart';
// import 'package:hospital/v5/api/staff/staff.dart';
// import 'package:hospital/v5/api/staff/staff_api.dart';
// import 'package:hux/hux.dart';

// class AvailableStaffs extends UI {
//   const AvailableStaffs({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return listView(staffsRepository.availableStaffs.values, (staff) {
//       return ListTile(
//         title: staff.name.text(),
//         subtitle: staff.role.text(),
//         trailing: HuxButton(
//           // style: FButtonStyle.primary(),
//           onPressed: () => hire_staff(staff),
//           child: Icon(FeatherIcons.filter),
//         ),
//       );
//     });
//   }
// }

// void hire_staff(Staff staff) {
//   balanceRepository.useBalance(
//     Receipt()
//       ..balance = staff.signingBonus
//       ..details = 'Signing Bonus',
//   );
//   staffsRepository.availableStaffs.remove(staff.id);
//   staffsRepository.hiredStaffs.putIfAbsent(staff.id, () => staff);
// }
