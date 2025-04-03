import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/domain/api/patients_repository.dart';
import 'package:hospital/main.dart';
import 'package:hospital/navigator.dart';

import '../../domain/models/patient.dart';

mixin WaitingPatientBloc {
  Injected<Patient> get patient => patientsRepository.single;
}

class WaitingPatientPage extends UI with WaitingPatientBloc {
  const WaitingPatientPage({super.key});
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: patient.state.name.text(),
        prefixActions: [
          FHeaderAction.back(onPress: navigator.back),
        ],
      ),
      content: patient.state.text(),
    );
  }
}
