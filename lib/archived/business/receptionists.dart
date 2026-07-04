// import 'package:hospital/archived/business/staffing.dart';
// import 'package:hospital/archived/data/models/staff.dart';
// import 'package:hospital/managers/manager.dart';

// final mapOfReceptionists = computed(
//   () => {
//     for (final staff in hiredStaffForRole(StaffRole.receptionist))
//       staff.id: staff,
//   },
// );
// final receptionists = computed(() => mapOfReceptionists.value.values);
// final activeReceptionist = computed(
//   () => activeStaffForRole(StaffRole.receptionist),
// );

// final isReceptionOpen = computed(() => activeReceptionist() != null);

// // void adminAssignReceptionistForDuty(Staff? receptionist) {
// //   assignStaffToDuty(StaffRole.receptionist, receptionist);
// // }

// void adminHiredReceptionist(Staff recep) {
//   hireStaff(recep);
// }

// void adminFiredReceptionist(Staff recep) {
//   fireStaff(recep);
// }
