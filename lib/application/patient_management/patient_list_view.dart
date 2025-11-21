import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/application/home.dart';

class PatientListView extends StatelessWidget {
  final List<PatientWithRecords> patients;
  final ValueChanged<PatientWithRecords> onTap;

  const PatientListView({
    super.key,
    required this.patients,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: patients.length,
      itemBuilder: (context, index) {
        final pwr = patients[index];
        final patient = pwr.patient;
        return FTile(
          title: Text(patient.name),
          subtitle: Text('Age: ${patient.age} | Gender: ${patient.gender}'),
          suffix: Text('Records: ${pwr.records.length}'),
          onPress: () => onTap(pwr),
        );
      },
    );
  }
}
