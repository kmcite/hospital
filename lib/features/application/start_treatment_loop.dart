import 'package:hospital/main.dart';
import 'package:hospital/repositories/receptions_api.dart';

import '../../models/consultation.dart';
import '../../repositories/staff_api.dart';

void startTreatmentLoop() async {
  print('[StartingTreatmentLoop]');
  while (true) {
    await Future.delayed(Duration(seconds: 1));
    if (!checkOnDutyStaff()) {
      continue;
    }
    if (!checkReceptions()) {
      continue;
    }

    if (staffRepository.currentNurse()!.isWorking()) {
      continue;
    }

    final reception =
        receptionsRepository.receptions.values.toList().removeLast();
    receptionsRepository.receptions.remove(reception.mr);
    reception.nurse = staffRepository.currentNurse();
    int time = 0;
    for (final act
        in reception.consultation?.options() ?? <ConsultationOptions>[]) {
      time += act.duration;
    }
    staffRepository.currentNurse.set(
      staffRepository.currentNurse()!..work(time),
    );
  }
}

bool checkOnDutyStaff() {
  if (staffRepository.currentReceptionist() == null) {
    print('NoReceptionistOnDuty - WaitingForDutyAssignment');
    return false;
  }
  if (staffRepository.currentNurse() == null) {
    print('NoNurseOnDuty - WaitingForDutyAssignment');
    return false;
  }
  if (staffRepository.currentDoctor() == null) {
    print('NoDoctorOnDuty - WaitingForDutyAssignment');
    return false;
  }
  return true;
}

bool checkReceptions() {
  if (receptionsRepository.receptions.isEmpty) {
    print('NoReceptionsAvailable');
    return false;
  } else {
    return true;
  }
}
