import 'dart:convert';

import 'package:hospital/main.dart';

class SettingsRepository extends Repository {
  final storage = find<Storage>();
  SettingsRepository() {
    read();
  }

  /// INSTANCE
  Settings settings = Settings();

  /// READ
  String get hospitalName => settings.hospitalName;

  double get patientFees => settings.patientFees;
  double get patientReferalFees => settings.patientReferalFees;
  double get ambulanceFees => settings.ambulanceFees;
  bool get dark => settings.dark;

  /// WRITE
  void setHospitalName(String value) {
    settings = settings..hospitalName = value;
    notifyListeners();
  }

  void setPatientFees(double value) {
    settings = settings..patientFees = value;
    notifyListeners();
  }

  void setPatientReferalFees(double value) {
    settings = settings..patientReferalFees = value;
    notifyListeners();
  }

  void setAmbulanceFees(double value) {
    settings = settings..ambulanceFees = value;
    notifyListeners();
  }

  void toggleDark() {
    settings = settings..dark = !dark;
    notifyListeners('dark: $dark');
  }
////

  @override
  void notifyListeners([String message = '']) {
    super.notifyListeners(message);
    save();
  }

  void save() {
    storage.save('settings', jsonEncode(settings.toJson()));
  }

  void read() {
    final jsonString = storage.get('settings');
    if (jsonString.isNotEmpty) {
      try {
        final json = jsonDecode(jsonString);
        settings = Settings.fromJson(json);
      } catch (e) {
        print('Error reading settings: $e');
      }
    }
    notifyListeners();
  }
}

class Settings {
  String hospitalName = 'My Hospital';
  double patientFees = 400.0;
  double patientReferalFees = 100.0;
  double ambulanceFees = 300;
  bool dark = false;
  Settings();
  Settings.fromJson(Map<String, dynamic> json) {
    hospitalName = json['hospitalName'] ?? hospitalName;
    patientFees = (json['patientFees'] ?? patientFees).toDouble();
    patientReferalFees =
        (json['patientReferalFees'] ?? patientReferalFees).toDouble();
    ambulanceFees = (json['ambulanceFees'] ?? ambulanceFees).toDouble();
    dark = json['dark'] ?? dark;
  }
  Map<String, dynamic> toJson() {
    return {
      'hospitalName': hospitalName,
      'patientFees': patientFees,
      'patientReferalFees': patientReferalFees,
      'ambulanceFees': ambulanceFees,
      'dark': dark,
    };
  }
}
