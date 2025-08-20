import 'dart:async';
import 'package:hospital/main.dart';

import '../../repositories/balance_api.dart';
import '../../models/receipt.dart';
import '../../repositories/staff_api.dart';

/// SALARIES AWARDING
void startGivingOutSalaries() async {
  while (true) {
    print('[AwardingSalariesToHiredStaffs]');
    for (final staff in [
      ...staffRepository.nurses.values,
      ...staffRepository.doctors.values,
      ...staffRepository.receptionists.values,
    ]) {
      balanceRepository.useBalance(
        Receipt()
          ..balance = staff.salary
          ..details = 'Salary',
      );
    }
    await Future.delayed(Duration(seconds: 30));
  }
}
