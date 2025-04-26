import 'package:flutter/material.dart';
import 'package:hospital/api/patients_repository.dart';
import 'package:hospital/main.dart';
import 'package:hospital/models/patient.dart';

CollectionModifier<Patient> get patients => patientsRepository;
void admit(Patient p) {
  patients(p..status = Status.admitted);
}

void refer(Patient p) {
  patients(p..status = Status.referred);
}

class TotalPatientsPage extends UI {
  @override
  get listenables => super.listenables..add(patientsRepository);

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: 'total patients'.text(),
      ),
      body: ListView(
        // label: 'patients'.text(),
        children: patients().map(
          (patient) {
            return ListTile(
              title: Text(patient.name),
              subtitle: Text(patient.status.toString()),
              trailing: Text(patient.remainingTime.toString()),
              onTap: patient.status == Status.admitted
                  ? null
                  : () => admit(patient),
            );
          },
        ).toList(),
      ),
    );
  }
}
