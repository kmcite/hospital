import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/domain/api/patient_repository.dart';
import 'package:hospital/domain/models/patient.dart';
import 'package:hospital/main.dart';
import 'package:hospital/navigator.dart';

mixin WaitingPatientBloc {
  Modifier<Patient> get patient => patientRepository;
}

class WaitingPatientPage extends UI with WaitingPatientBloc {
  const WaitingPatientPage({super.key});
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: patient().name.text(),
        prefixActions: [
          FHeaderAction.back(onPress: navigator.back),
        ],
      ),
      content: patient().text(),
    );
  }
}
