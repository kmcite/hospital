// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hospital/domain/repositories/patients_repository.dart';
import 'package:hospital/main.dart';

final _remaningTimeRM = RM.injectStream(
  () => patientsRepository.remainingTimeForNextPatientController.stream,
  initialState: 0.0,
);

class Indicator extends UI {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: 400.milliseconds,
      tween: Tween(begin: 0.0, end: _remaningTimeRM.state),
      builder: (context, value, snapshot) {
        return CircularProgressIndicator(value: value);
      },
    );
  }
}
