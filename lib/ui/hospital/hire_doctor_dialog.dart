import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/domain/api/doctors.dart';
import 'package:hospital/domain/api/settings_repository.dart';
import 'package:hospital/domain/models/doctor.dart';
import 'package:hospital/main.dart';
import 'package:hospital/navigator.dart' show navigator;
import 'package:states_rebuilder/states_rebuilder.dart';

mixin HireDoctorX {
  late final doctorRM = signal(_generateDoctor());
  bool get isHiringLimitReached =>
      doctorsRepository.getAll().length >= settingsRepository().doctorsCapacity;
  Doctor _generateDoctor() => Doctor()
    ..price = random.integer(
      200,
      min: 50,
    );

  void confirmHiring() {
    if (isHiringLimitReached) {
      RM.scaffold.showSnackBar(
        SnackBar(
          content:
              'Hiring limit reached. please upgrade hiring capacity.'.text(),
        ),
      );
    }
    navigator.back();
  }
}

class HireDoctorDialog extends UI with HireDoctorX {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: !isHiringLimitReached
          ? 'HIRING LIMIT REACHED'.text().pad()
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                'HIRE DOCTOR?'.text().pad(),
                doctorRM().name.text(),
                doctorRM().price.text(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: navigator.back,
                      icon: FIcon(FAssets.icons.x),
                    ),
                    IconButton(
                      onPressed: () => doctorRM,
                      icon: FIcon(FAssets.icons.refreshCcw),
                    ),
                    IconButton(
                      onPressed: confirmHiring,
                      icon: FIcon(FAssets.icons.checkCheck),
                    ),
                  ],
                ),
              ],
            ).pad(),
    );
  }
}
