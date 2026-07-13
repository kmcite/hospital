// import 'package:hospital/archived/business/staffing.dart';
// import 'package:hospital/archived/data/models/patient.dart';
// import 'package:hospital/archived/data/models/staff.dart';
// import 'package:hospital/managers/manager.dart';

// final class MinorOperatingRoomManager extends Manager<int> {
//   Patient? currentPatient;
//   Staff? currentStaff;

//   MinorOperatingRoomManager() : super(0);
// }

// final mapOfOtAssistants = computed(
//   () => {for (final staff in hiredStaffForRole(StaffRole.ota)) staff.id: staff},
// );

// final listOfOtas = computed(() => mapOfOtAssistants.value.values);
// final activeTechnitian = computed(() => activeStaffForRole(StaffRole.ota));

// void adminHiredOta(Staff ota) {
//   hireStaff(ota);
// }

// void adminFiredOta(Staff ota) {
//   fireStaff(ota);
// }

// final isMinorOtFunctional = computed(
//   () => activeStaffForRole(.ota) != null && mapOfOtAssistants.value.isNotEmpty,
// );
