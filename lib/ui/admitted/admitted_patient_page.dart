// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/domain/api/patients_repository.dart';
import 'package:hospital/domain/models/patient.dart';
import 'package:hospital/main.dart';
import 'package:hospital/navigator.dart';

mixin AdmittedPatientBloc {
  Injected<Patient> get patient => patientsRepository.single;
  void refer() {
    // set(patient.copyWith(status: Status.referred));
    // patientsRepository.put(patient);
    back();
  }

  void discharge() {
    // set(patient.copyWith(status: Status.discharged));
    // patientsRepository.put(patient);
    back();
  }

  void back() {
    navigator.back();
  }
}

class AdmittedPatientPage extends UI with AdmittedPatientBloc {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        prefixActions: [
          FHeaderAction.back(
            onPress: navigator.back,
          ),
        ],
        suffixActions: [
          FButton.icon(
            style: FButtonStyle.secondary,
            child: FIcon(FAssets.icons.receipt),
            onPress: discharge,
          ),
          FButton.icon(
            style: FButtonStyle.destructive,
            onPress: refer,
            child: FIcon(FAssets.icons.cross),
          ),
        ],
        title: patient.state.name.text(),
      ),
      content: Wrap(
        children: [
          FBadge(label: patient.state.id.text()).pad(),
          FBadge(label: patient.state.name.text()).pad(),
          // FBadge(label: patient.state.symptom.text()).pad(),
          FBadge(label: patient.state.admissionTime.text()).pad(),
          FBadge(label: patient.state.remainingTime.text()).pad(),
          // FBadge(label: patient.state.isEmergency.text()).pad(),
          FBadge(label: patient.state.canPay.text()).pad(),
          FBadge(label: patient.state.satisfaction.text()).pad(),
          FBadge(
            label: patient.state.urgency.text(),
          ).pad(),
          FButton(
            onPress: () {
              final urgency = switch (patient.state.urgency) {
                Urgency.stable => Urgency.critical,
                Urgency.critical => Urgency.lifeThreatening,
                Urgency.lifeThreatening => Urgency.stable,
              };
              // admittedPatient.stateoc.set(patient.stateopyWith(urgency: urgency));
            },
            label: 'Stabilise patient.state'.text(),
          ).pad(),
          FButton(
            onPress: () {
              final urgency = switch (patient.state.urgency) {
                Urgency.stable => Urgency.critical,
                Urgency.critical => Urgency.lifeThreatening,
                Urgency.lifeThreatening => Urgency.stable,
              };
              // admittedPatient.stateoc.set(patient.stateopyWith(urgency: urgency));
            },
            label: 'Mark as critical'.text(),
          ).pad(),
          // FBadge(label: patient.statesAdmitted.text()).pad(),
          // FBadge(label: patient.statesAlive.text()).pad(),
          FBadge(label: patient.state.status.text()).pad(),
          // FBadge(label: patient().investigations.text()).pad(),
        ],
      ),
    );
  }
}
