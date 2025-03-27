import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/domain/api/patient_repository.dart';
import 'package:hospital/domain/api/settings_repository.dart';
import 'package:hospital/domain/models/patient.dart';
import 'package:hospital/domain/api/patients_repository.dart';
import 'package:hospital/domain/models/settings.dart';
import 'package:hospital/ui/admitted/admitted_patient_page.dart';
import 'package:hospital/main.dart';
import 'package:hospital/navigator.dart';
import 'package:hospital/ui/core/funds_badge.dart';

mixin class AdmittedPatientsBloc {
  Iterable<Patient> get admittedPatients {
    return patientsRepository.getPatientsByStatus(Status.admitted);
  }

  Modifier<Settings> get settings => settingsRepository;

  void remove(Patient patient) {
    int amountToAddToFunds = 0;
    for (var symptom in patient.symptoms) {
      amountToAddToFunds += symptom.cost;
    }
    settings(
      settings()..funds += amountToAddToFunds,
    );
    patient.status = Status.discharged;
    patientsRepository.put(patient);
  }

  Modifier<Patient> get patient => patientRepository;
}

class AdmittedPatientsPage extends UI with AdmittedPatientsBloc {
  const AdmittedPatientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        prefixActions: [
          FHeaderAction.back(onPress: navigator.back),
        ],
        title: 'Admitted Patients'.text(),
        suffixActions: [
          FundsBadge(),
          CharityBadge(),
        ],
      ),
      content: Column(
        // divider: FTileDivider.full,
        children: admittedPatients.map(
          (_patient) {
            return FTile(
              title: _patient.name.text(),
              subtitle: Column(
                children: [
                  ..._patient.symptoms.map(
                    (symptom) {
                      return FBadge(
                        label: symptom.text(),
                      );
                    },
                  ),
                ],
              ),
              onPress: () {
                patient(_patient);
                navigator.to(AdmittedPatientPage());
              },
              suffixIcon: FButton.icon(
                style: FButtonStyle.destructive,
                onPress: () => remove(_patient),
                child: FIcon(FAssets.icons.delete),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
