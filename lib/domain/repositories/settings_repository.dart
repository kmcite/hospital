import 'package:flutter/material.dart';
import 'package:hospital/utils/notifier.dart';

class SettingsRepository extends Notifier {
  SettingsRepository(super.context); // Context not needed for repositories

  var _settings = Settings();
  Settings get settings => _settings;

  void update(Settings value) {
    _settings = value;
    notifyListeners();
  }

  void onPageChanged(int index) {
    _settings.pageIndex = index;
    notifyListeners();
  }
}

class Settings {
  bool dark = false;
  bool autoAdd = false;
  ThemeMode themeMode = ThemeMode.system;
  int pageIndex = 0;
}
