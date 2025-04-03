import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/domain/api/patients_repository.dart';
import 'package:hospital/domain/models/patient.dart';
import 'package:hospital/main.dart';
import 'package:hospital/navigator.dart';
import 'package:hospital/ui/core/funds_badge.dart';

mixin TotalPatientsBloc {
  Iterable<Patient> get patients => [
        // patientsRepository.getAll()
      ];
  void admit(Patient p) {
    patientsRepository.put(p..status = Status.admitted);
  }

  void refer(Patient p) {
    patientsRepository.put(p..status = Status.referred);
  }
}

class TotalPatientsPage extends UI with TotalPatientsBloc {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: 'Total'.text(),
        prefixActions: [
          FHeaderAction.back(onPress: navigator.back),
        ],
        suffixActions: [
          FundsBadge(),
          CharityBadge(),
        ],
      ),
      content: ListView(
        children: patients.map(
          (patient) {
            return FTile(
              title: patient.text(),
              subtitle: patient.status.text(),
              onPress: patient.status == Status.admitted
                  ? null
                  : () => admit(patient),
            ).pad();
          },
        ).toList(),
      ),
    );
  }
}
