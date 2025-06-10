// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/cupertino.dart';

import '../../main.dart';
import '../models/settings.dart';

final settingsRepository = SettingsRepository();
final indexRM = RM.injectTabPageView(length: 4, initialIndex: 2);

class SettingsRepository extends ChangeNotifier {
  final settingsRM = RM.inject(() => Settings());

  Settings settings([Settings? value]) {
    if (value != null) {
      settingsRM.state = value;
      settingsRM.notify();
      notifyListeners();
    }
    return settingsRM.state;
  }

  @deprecated
  bool dark([bool? value]) {
    if (value != null) {
      settings(settings()..dark = value);
      notifyListeners();
    }
    return settings().dark;
  }

  int doctorsCapacity([int? value]) {
    if (value != null) {
      settings(settings()..doctorsCapacity = value);
      notifyListeners();
    }
    return settings().doctorsCapacity;
  }

  int nursingCapacity([int? value]) {
    if (value != null) {
      settings(settings()..nursingCapacity = value);
      notifyListeners();
    }
    return settings().nursingCapacity;
  }

  int beds([int? value]) {
    if (value != null) {
      settings(settings()..beds = value);
      notifyListeners();
    }
    return settings().beds;
  }

  int waitingBeds([int? value]) {
    if (value != null) {
      settings(settings()..waitingBeds = value);
      notifyListeners();
    }
    return settings().waitingBeds;
  }

  int charity([int? value]) {
    if (value != null) {
      settings(settings()..charity = value);
      notifyListeners();
    }
    return settings().charity;
  }

  int funds([int? value]) {
    if (value != null) {
      settings(settings()..funds = value);
      notifyListeners();
    }
    return settings().funds;
  }
}
