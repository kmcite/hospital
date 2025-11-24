import 'package:flutter/material.dart';
import 'package:hospital/features/home.dart';

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
        return Card(
          child: ListTile(
            title: Text(patient.name),
            subtitle: Text('Age: ${patient.age} | Gender: ${patient.gender}'),
            trailing: Text('Records: ${pwr.records.length}'),
            onTap: () => onTap(pwr),
          ),
        );
      },
    );
  }
}
