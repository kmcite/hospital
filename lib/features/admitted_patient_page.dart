// ignore_for_file: unused_local_variable

import 'package:forui/forui.dart';
import 'package:hospital/domain/models/patient.dart';
import 'package:hospital/main.dart';
import 'package:hospital/navigator.dart';

final admittedPatientBloc = AdmittedPatientBloc();

class AdmittedPatientBloc {
  final patientRM = RM.inject(() => Patient());
  Patient get patient => patientRM.state;
  void set(Patient patient) => patientRM
    ..state = patient
    ..notify();

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
    set(Patient());
    navigator.back();
  }
}

class AdmittedPatientPage extends UI {
  Patient get patient => admittedPatientBloc.patient;
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        prefixActions: [
          FHeaderAction.back(
            onPress: admittedPatientBloc.back,
          ),
        ],
        suffixActions: [
          FButton.icon(
            style: FButtonStyle.secondary,
            child: FIcon(FAssets.icons.receipt),
            onPress: admittedPatientBloc.discharge,
          ),
          FButton.icon(
            style: FButtonStyle.destructive,
            onPress: admittedPatientBloc.refer,
            child: FIcon(FAssets.icons.cross),
          ),
        ],
        title: patient.name.text(),
      ),
      content: Wrap(
        children: [
          FBadge(label: patient.id.text()).pad(),
          FBadge(label: patient.name.text()).pad(),
          FBadge(label: patient.symptom.text()).pad(),
          FBadge(label: patient.admissionTime.text()).pad(),
          FBadge(label: patient.remainingTime.text()).pad(),
          FBadge(label: patient.isEmergency.text()).pad(),
          FBadge(label: patient.canPay.text()).pad(),
          FBadge(label: patient.satisfaction.text()).pad(),
          FBadge(
            label: patient.urgency.text(),
          ).pad(),
          FButton(
            onPress: () {
              final urgency = switch (patient.urgency) {
                Urgency.stable => Urgency.critical,
                Urgency.critical => Urgency.lifeThreatening,
                Urgency.lifeThreatening => Urgency.stable,
              };
              // admittedPatientBloc.set(patient.copyWith(urgency: urgency));
            },
            label: 'Stabilise patient'.text(),
          ).pad(),
          FButton(
            onPress: () {
              final urgency = switch (patient.urgency) {
                Urgency.stable => Urgency.critical,
                Urgency.critical => Urgency.lifeThreatening,
                Urgency.lifeThreatening => Urgency.stable,
              };
              // admittedPatientBloc.set(patient.copyWith(urgency: urgency));
            },
            label: 'Mark as critical'.text(),
          ).pad(),
          FBadge(label: patient.isAdmitted.text()).pad(),
          FBadge(label: patient.isAlive.text()).pad(),
          FBadge(label: patient.status.text()).pad(),
          FBadge(label: patient.investigations.text()).pad(),
        ],
      ),
    );
  }
}
