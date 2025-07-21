import 'package:flutter/material.dart';
import 'package:hospital/main.dart';
import 'package:hospital/utils/list_view.dart';
import 'package:hospital/v5/patients/patient.dart';

class PatientsUI extends UI {
  @override
  Widget build(BuildContext context) {
    return listView(
      patients(),
      (patient) {
        return FTile(
          title: patient.name.text(),
          subtitle: patient.complaints.text(),
          suffix: Column(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FButton.icon(
                style: FButtonStyle.primary(),
                onPress: () => manage_patient(patient),
                child: Icon(FIcons.ghost),
              ),
              FButton.icon(
                style: FButtonStyle.primary(),
                onPress: () => refer_patient_elsewhere(patient),
                child: Icon(FIcons.arrowRightFromLine),
              ),
            ],
          ),
        );
      },
    );
  }
}
