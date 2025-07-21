import 'package:flutter/material.dart';
import 'package:hospital/main.dart';
import 'package:hospital/utils/navigator.dart';
import 'package:hospital/v5/balance/balance.dart';
import 'package:hospital/v5/config/config.dart';
import 'package:hospital/v5/patients/counter.dart';
import 'package:hospital/v5/patients/patients_ui.dart';
import 'package:hospital/v5/staff/staff.dart';

class Dashboard extends UI {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: clinicName.text(),
        suffixes: [
          FButton.icon(
            style: FButtonStyle.destructive(),
            onPress: () {},
            child: amountOfPatientsManaged().text(
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          FButton.icon(
            style: FButtonStyle.primary(),
            onPress: () => navigator.to(ConfigPage()),
            child: Icon(FIcons.settings),
          )
        ],
      ),
      child: Column(
        children: [
          Balance(),
          Expanded(
            child: PatientsUI(),
          ),
          Expanded(
            child: StaffsUI(),
          ),
        ],
      ),
    );
  }
}
