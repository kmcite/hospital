import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/domain/models/doctor.dart';
import 'package:hospital/main.dart';
import 'package:hospital/navigator.dart';

mixin HireDoctorX {
  late final doctorRM = RM.inject(_generateDoctor);
  bool get isHiringLimitReached => true
      // doctorsRepository.getAll().length >= settingsRepository().doctorsCapacity
      ;
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
                doctorRM.state.name.text(),
                doctorRM.state.price.text(),
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
