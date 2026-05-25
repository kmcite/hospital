import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital/features/doctor_room.dart';
import 'package:hospital/features/gatekeeper.dart';
import 'package:hospital/utils/navigation.dart';

class DarkCubit extends Cubit<bool> {
  DarkCubit() : super(false);
  void onDarkToggled() {
    emit(!state);
  }
}

enum GameState { running, paused }

@deprecated
final gameStateSignal = ValueNotifier(GameState.paused);

/// will be triggered at startup
final gameStateEffect = () {
  switch (gameStateSignal.value) {
    case GameState.running:
      navigateUntill(DoctorRoom());
      break;
    case GameState.paused:
      navigateUntill(Gatekeeper());
      break;
  }
};
// import 'package:flutter/foundation.dart';
// // import 'package:hospital/data/patient.dart';

// @deprecated
// final patients = ValueNotifier(<Patient>[]);
// @deprecated
// final treatedPatients = ValueNotifier(<Patient>[]);
// @deprecated
// final expiredPatients = ValueNotifier(<Patient>[]);
// import 'package:flutter/material.dart';

// final money = ValueNotifier<double>(100.0);
