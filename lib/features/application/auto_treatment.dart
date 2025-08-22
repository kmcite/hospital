import 'dart:async';
import 'package:hospital/main.dart';
import 'package:hospital/repositories/receptions_api.dart';

import '../../repositories/balance_api.dart';
import '../../models/consultation.dart';
import '../../repositories/patients_api.dart';
import '../../models/receipt.dart';
import '../../repositories/staff_api.dart';

/// auto-treats patients every 10 seconds
void autoTreatment() async {
  while (true) {
    await Future.delayed(Duration(seconds: 10));
    if (receptionsRepository.receptions.isNotEmpty) {
      if (staffRepository.currentDoctor() == null) {
        print('[NoDoctorOnDuty]');
        if (staffRepository.doctors().isNotEmpty) {
          final doctor = staffRepository.doctors().first;
          staffRepository.currentDoctor.set(doctor);
        } else {
          print('[NoDoctorAvailable]');
        }
      } else {
        final all = receptionsRepository.receptions.values.toList();
        final chit = all.removeLast();
        receptionsRepository.receptions.remove(chit.mr);
        // START CONSULTATION
        chit.doctor = staffRepository.currentDoctor();
        chit.consultation = Consultation()
          ..options.addAll(
            faker.randomGenerator.amount(
              (i) => ConsultationOptions.values[i],
              ConsultationOptions.values.length,
            ),
          );

        balanceRepository.useBalance(
          Receipt(
            balance: patientFees(),
            metadata: {'type': 'Consultation Fees'},
          ),
        );
        receptionsRepository.receptions[chit.mr] = chit;
        managedPatients[chit.mr] = chit.patient;
      }
    }
  }
}
