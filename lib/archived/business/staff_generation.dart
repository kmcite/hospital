// import 'dart:async';

// import 'package:faker/faker.dart';
// import 'package:hospital/archived/business/staffing.dart';
// import 'package:hospital/archived/data/models/staff.dart';
// import 'package:hospital/managers/manager.dart';

// final generateStaffForHiring = listSignal(<Staff>[]);

// final progressOfGeneration = signal<double>(0);
// final remainingStaffGenerationSeconds = signal<int>(30);

// Timer? generateStaffForHiringTimer;

// const int staffRefreshSeconds = 30;

// void startAdministrationActivities() {
//   if (generateStaffForHiringTimer != null) return;

//   startStaffPayroll();
//   refreshHirableStaff();
//   resetStaffGenerationProgress();

//   generateStaffForHiringTimer = Timer.periodic(
//     const Duration(seconds: 1),
//     (_) => tickStaffGeneration(),
//   );
// }

// void stopAdministrationActivities() {
//   generateStaffForHiringTimer?.cancel();
//   generateStaffForHiringTimer = null;
// }

// void tickStaffGeneration() {
//   final remaining = remainingStaffGenerationSeconds.value - 1;

//   remainingStaffGenerationSeconds.value = remaining;

//   progressOfGeneration.value =
//       1 - (remaining / staffRefreshSeconds).clamp(0, 1);

//   if (remaining <= 0) {
//     refreshHirableStaff();
//     resetStaffGenerationProgress();
//   }
// }

// void resetStaffGenerationProgress() {
//   remainingStaffGenerationSeconds.value = staffRefreshSeconds;
//   progressOfGeneration.value = 0;
// }

// void refreshHirableStaff() {
//   final staff = [
//     for (final role in StaffRole.values) Staff(role: role),
//     for (final role in StaffRole.values) Staff(role: role),
//     ...faker.randomGenerator.amount((_) => Staff(), 6, min: 3),
//   ];

//   generateStaffForHiring.set(staff);
// }
