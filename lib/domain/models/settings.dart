class Settings {
  int doctorsCapacity = 1;
  int nursingCapacity = 1;
  int funds = 100;
  int charity = 100;
  int beds = 4;
  int waitingBeds = 4;

  @deprecated
  bool dark = false;

  Settings({
    this.doctorsCapacity = 1,
    this.nursingCapacity = 1,
    this.funds = 100,
    this.charity = 100,
    this.beds = 4,
    this.waitingBeds = 4,
    this.dark = true,
  });

  Settings.fromJson(Map<String, dynamic> json)
      : doctorsCapacity = json['doctorsCapacity'] ?? 1,
        nursingCapacity = json['nursingCapacity'] ?? 1,
        funds = json['funds'] ?? 100,
        charity = json['charity'] ?? 100,
        beds = json['admissionBeds'] ?? 4,
        waitingBeds = json['waitingBeds'] ?? 4;

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
      beds: admissionBeds ?? beds,
      waitingBeds: waitingBeds ?? this.waitingBeds,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "doctorsCapacity": doctorsCapacity,
      "nursingCapacity": nursingCapacity,
      "funds": funds,
      "charity": charity,
      "admissionBeds": beds,
      "waitingBeds": waitingBeds,
    };
  }
}
