import 'dart:async';
import 'package:hospital/main.dart';
import 'package:hospital/repositories/balance_api.dart';
import 'package:hospital/models/reception.dart';
import 'package:hospital/repositories/patients_api.dart';
import 'package:hospital/models/receipt.dart';

import '../../repositories/staff_api.dart';

void startIssuingChits() async {
  print('[StartIssuingChits]');
  while (true) {
    await Future.delayed(Duration(seconds: 1));
    if (staffRepository.currentReceptionist() == null) {
      continue;
    } else {
      for (final pt in receptionistQueue.values) {
        var reception = Reception(
          patient: pt,
          receptionist: staffRepository.currentReceptionist()!,
        );
        receptions[reception.mr] = reception;
        balanceRepository.useBalance(
          Receipt(
            balance: reception.fees,
            details: 'Chit for ${reception.patient.name}',
          ),
        );
        await Future.delayed(
          Duration(milliseconds: 600),
        );
      }
      receptionistQueue.clear();
    }
  }
}
