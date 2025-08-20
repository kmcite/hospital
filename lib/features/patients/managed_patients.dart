import 'package:flutter/material.dart';
import 'package:hospital/main.dart';
import 'package:hospital/utils/list_view.dart';
import 'package:hux/hux.dart';

import '../../repositories/patients_api.dart';

final amountOfManagedPatients = computed(() => managedPatients.length);

class ManagedPatients extends UI {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Managed Patients'),
      ),
      body: listView(
        managedPatients.values,
        (patient) {
          return HuxCard(
            title: patient.name,
            subtitle: patient.complaints,
            child: patient.id.text(),
          );
        },
      ),
    );
  }
}
