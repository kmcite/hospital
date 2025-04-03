import 'package:flutter/material.dart';
import 'package:hospital/ui/admitted/admitted_patients_page.dart';
import 'package:hospital/ui/total.dart';
import 'package:hospital/main.dart';
import 'package:hospital/navigator.dart';

import '../waiting/waiting_patients_page.dart';

mixin HospitalCountersX on UI {
  // int get numberOfTotalPatients => patientsRepository.getAll().length;
  // int get numberOfAdmittedPatients =>
  //     patientsRepository.getPatientsByStatus(Status.admitted).length;
  // int get numberOfWaitingPatients =>
  //     patientsRepository.numberOfWaitingPatients();
}

class HospitalCounters extends UI with HospitalCountersX {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        'counters'.text(),
        ListTile(
          title: 'total patients'.text(),
          // trailing: numberOfTotalPatients.text(),
          onTap: () => navigator.to(TotalPatientsPage()),
        ),
        ListTile(
          title: 'admitted patients'.text(),
          // trailing: numberOfAdmittedPatients.text(),
          onTap: () => navigator.to(AdmittedPatientsPage()),
        ),
        // LinearProgressIndicator(value: numberOfWaitingPatients / 10),
        ListTile(
          title: 'waiting patients'.text(),
          // trailing: numberOfWaitingPatients.text(),
          onTap: () {
            navigator.to(WaitingPatientsPage());
          },
        ),
      ],
    );
  }
}
