class Settings {
  int doctorsCapacity = 1;
  int nursingCapacity = 1;
  int funds = 100;
  int charity = 100;
  int admissionBeds = 4;
  int waitingBeds = 4;

  ///
  bool dark = false;

  Settings({
    this.doctorsCapacity = 1,
    this.nursingCapacity = 1,
    this.funds = 100,
    this.charity = 100,
    this.admissionBeds = 4,
    this.waitingBeds = 4,
    this.dark = false,
  });

  Settings.fromJson(Map<String, dynamic> json)
      : doctorsCapacity = json['doctorsCapacity'] ?? 1,
        nursingCapacity = json['nursingCapacity'] ?? 1,
        funds = json['funds'] ?? 100,
        charity = json['charity'] ?? 100,
        admissionBeds = json['admissionBeds'] ?? 4,
        waitingBeds = json['waitingBeds'] ?? 4,
        dark = json['dark'] ?? false;

  Settings copyWith({
    int? doctorsCapacity,
    int? nursingCapacity,
    int? funds,
    int? charity,
    int? admissionBeds,
    int? waitingBeds,
    bool? dark,
  }) {
    return Settings(
      doctorsCapacity: doctorsCapacity ?? this.doctorsCapacity,
      nursingCapacity: nursingCapacity ?? this.nursingCapacity,
      funds: funds ?? this.funds,
      charity: charity ?? this.charity,
      admissionBeds: admissionBeds ?? this.admissionBeds,
      waitingBeds: waitingBeds ?? this.waitingBeds,
      dark: dark ?? this.dark,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "doctorsCapacity": doctorsCapacity,
      "nursingCapacity": nursingCapacity,
      "funds": funds,
      "charity": charity,
      "admissionBeds": admissionBeds,
      "waitingBeds": waitingBeds,
      "dark": dark,
    };
  }
}
