import 'package:flutter/material.dart';
import 'package:hospital/main.dart';

import '../../models/patient.dart';

Widget patientDetailsPage(Patient pt) {
  return GUI(
    () {
      return Scaffold(
        appBar: AppBar(
          title: pt.name.text(),
        ),
        body: pt.text(),
      );
    },
  );
}
