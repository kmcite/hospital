// import 'dart:async';

// import 'package:hospital/archived/business/revenue.dart';
// import 'package:hospital/archived/data/models/staff.dart';
// import 'package:hospital/managers/manager.dart';

// final hiredStaff = mapSignal(<String, Staff>{});
// final staffDutySlots = mapSignal(<StaffRole, Staff?>{
//   for (final role in StaffRole.values) role: null,
// });
// final lastStaffingMessage = signal<String?>(null);
// final isDoctorRoomFunctional = computed(
//   () => activeStaffForRole(StaffRole.doctor) != null,
// );
// final isWardFunctional = computed(
//   () => activeStaffForRole(StaffRole.nurse) != null,
// );

// Timer? _payrollTimer;

// const payrollPeriod = Duration(seconds: 45);

// Iterable<Staff> hiredStaffForRole(StaffRole role) {
//   return hiredStaff.values.where((staff) => staff.role == role);
// }

// Staff? activeStaffForRole(StaffRole role) {
//   return staffDutySlots[role];
// }

// bool isStaffOnDuty(Staff staff) {
//   return staffDutySlots.values.any((assigned) => assigned?.id == staff.id);
// }

// bool hireStaff(Staff candidate) {
//   if (hiredStaff.containsKey(candidate.id)) return false;

//   final hired = candidate.hired();
//   final paid = spendMoney(
//     hired.signingBonus,
//     title: '${hired.name} signing bonus',
//     category: 'Hiring - ${hired.role.label}',
//   );

//   if (!paid) {
//     lastStaffingMessage.value =
//         'Not enough money to hire ${candidate.name}. Need Rs. ${candidate.signingBonus}.';
//     return false;
//   }

//   hiredStaff[hired.id] = hired;
//   lastStaffingMessage.value =
//       '${hired.name} hired as ${hired.role.label} for Rs. ${hired.signingBonus}.';
//   return true;
// }

// bool fireStaff(Staff staff) {
//   final employed = hiredStaff[staff.id];
//   if (employed == null) return false;

//   final paid = spendMoney(
//     employed.firingCost,
//     title: '${employed.name} severance',
//     category: 'Firing - ${employed.role.label}',
//   );

//   if (!paid) {
//     lastStaffingMessage.value =
//         'Not enough money to fire ${employed.name}. Need Rs. ${employed.firingCost}.';
//     return false;
//   }

//   clearDutyForStaff(employed);
//   hiredStaff.remove(employed.id);
//   lastStaffingMessage.value =
//       '${employed.name} fired. Severance paid Rs. ${employed.firingCost}.';
//   return true;
// }

// void assignStaffToDuty(StaffRole role, Staff? staff) {
//   if (staff == null) {
//     staffDutySlots[role] = null;
//     return;
//   }

//   final employed = hiredStaff[staff.id];
//   if (employed == null || employed.role != role) return;

//   clearDutyForStaff(employed);
//   staffDutySlots[role] = employed;
// }

// void clearDutyForStaff(Staff staff) {
//   for (final role in StaffRole.values) {
//     if (staffDutySlots[role]?.id == staff.id) {
//       staffDutySlots[role] = null;
//     }
//   }
// }

// void startStaffPayroll() {
//   _payrollTimer ??= Timer.periodic(payrollPeriod, (_) => paySalaries());
// }

// void paySalaries() {
//   for (final staff in hiredStaff.values) {
//     final paid = spendMoney(
//       staff.salary,
//       title: '${staff.name} salary',
//       category: 'Payroll - ${staff.role.label}',
//     );

//     if (!paid) {
//       lastStaffingMessage.value =
//           'Payroll missed for ${staff.name}. Need Rs. ${staff.salary}.';
//       return;
//     }
//   }
// }
