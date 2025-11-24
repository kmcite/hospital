import 'package:flutter/material.dart';
import 'package:hospital/domain/models/medical_record.dart';
import 'package:hospital/features/home.dart';
import 'package:hospital/features/patient_management/new_patient.dart';
import 'package:hospital/utils/notifier_provider.dart';
import 'package:hospital/utils/navigator.dart';

class PatientDetailsNotifier extends ChangeNotifier {
  final BuildContext context;

  PatientDetailsNotifier(this.context);

  void addMedicalRecordToPatient(MedicalRecordModel record) {
    // widget.patient.medicalRecords.add(record.id);
    // // update medical records
    // medicalRecords.put(record);
    // // update patients
    // patients.put(widget.patient);
    // setState(() {});
  }
}

class PatientDetails extends StatelessWidget {
  final PatientWithRecords pwr;

  const PatientDetails({super.key, required this.pwr});

  @override
  Widget build(BuildContext context) {
    final patient = pwr.patient;
    final records = pwr.records;
    return NotifierProvider(
      create: PatientDetailsNotifier.new,
      builder: (context, patientDetails) => Scaffold(
        appBar: AppBar(
          title: Text(patient.name),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: navigator.back,
          ),
        ),
        body: ListView(
          children: [
            ListTile(
              title: const Text('Age'),
              subtitle: Text(patient.age.toString()),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  navigator.toDialog(const NewPatientDialog());
                },
              ),
            ),
            ListTile(
              title: const Text('Gender'),
              subtitle: Text(patient.gender),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  navigator.toDialog(const NewPatientDialog());
                },
              ),
            ),
            ListTile(
              title: const Text('Records'),
              subtitle: Text('${records.length}'),
              trailing: ElevatedButton.icon(
                onPressed: () => patientDetails.addMedicalRecordToPatient(
                  MedicalRecordModel(),
                ),
                icon: const Icon(Icons.add),
                label: const Text('Add'),
              ),
            ),
            ListTile(
              title: const Text('Medical Records'),
              subtitle: Text('${records.length}'),
              trailing: ElevatedButton.icon(
                onPressed: () => patientDetails.addMedicalRecordToPatient(
                  MedicalRecordModel(),
                ),
                icon: const Icon(Icons.add),
                label: const Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
