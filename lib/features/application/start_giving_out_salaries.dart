import 'dart:async';
import 'package:hospital/main.dart';

import '../../repositories/balance_api.dart';
import '../../repositories/staff_api.dart';

/// SALARIES AWARDING
void startGivingOutSalaries() async {
  while (true) {
    print('[AwardingSalariesToHiredStaffs]');

    /// O(N) complexity
    for (final staff in staffRepository.staffs.values) {
      balanceRepository.send(
        SalaryImbursement(staff.salary, staff.id),
      );
    }
    await Future.delayed(Duration(seconds: 30));
  }
}
