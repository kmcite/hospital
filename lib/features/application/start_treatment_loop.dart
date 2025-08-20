import 'package:hospital/main.dart';

import '../../models/consultation.dart';
import '../../repositories/patients_api.dart';
import '../../repositories/staff_api.dart';

void startTreatmentLoop() async {
  print('[StartingTreatmentLoop]');
  while (true) {
    await Future.delayed(Duration(seconds: 1));
    if (staffRepository.currentReceptionist() == null) {
      print('NoReceptionistOnDuty - WaitingForDutyAssignment');
      continue;
    }
    if (staffRepository.currentNurse() == null) {
      print('NoNurseOnDuty - WaitingForDutyAssignment');
      continue;
    }
    if (staffRepository.currentDoctor() == null) {
      print('NoDoctorOnDuty - WaitingForDutyAssignment');
      continue;
    }

    if (staffRepository.currentNurse()!.isWorking()) {
      continue;
    }
    if (receptions.isEmpty) {
      print('NoReceptionsAvailable');
      continue;
    }
    final reception = receptions.values.toList().removeLast();
    receptions.remove(reception.mr);
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
