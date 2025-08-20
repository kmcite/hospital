import 'package:flutter/material.dart';
import 'package:hospital/main.dart';
import 'package:hospital/utils/navigator.dart';
import 'package:hospital/features/balance/receipts.dart';
import 'package:hospital/features/patients/managed_patients.dart';
import 'package:hospital/features/reception/reception_station.dart';
import 'package:hospital/features/settings/settings.dart';
import 'package:hux/hux.dart';

import '../patients/referred_patients.dart';

class CommonActions extends UI {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        HuxButton(
          onPressed: () => navigator.to(ReferredPatients()),
          child: Icon(FeatherIcons.filter),
        ),
        HuxButton(
          onPressed: () => navigator.to(ManagedPatients()),
          child: Icon(FeatherIcons.heart),
        ),
        HuxButton(
          onPressed: () => navigator.to(ReceiptsPage()),
          child: Icon(FeatherIcons.dollarSign),
        ),
        HuxButton(
          onPressed: () => navigator.to(ReceptionStation()),
          child: Icon(FeatherIcons.messageCircle),
        ),
        HuxButton(
          onPressed: () => navigator.to(SettingsPage()),
          child: Icon(FeatherIcons.settings),
        ),
      ],
    ).pad();
  }
}
