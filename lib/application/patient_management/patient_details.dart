import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/domain/models/medical_record.dart';
import 'package:hospital/application/home.dart';
import 'package:hospital/application/patient_management/new_patient.dart';
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
      builder: (context, patientDetails) => FScaffold(
        header: FHeader(
          title: Text(patient.name),
          suffixes: [
            FHeaderAction.x(onPress: navigator.back),
          ],
        ),
        child: ListView(
          children: [
            FTile(
              title: Text('Age'),
              subtitle: Text(patient.age.toString()),
              suffix: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  navigator.toDialog(NewPatientDialog());
                },
              ),
            ),
            FTile(
              title: Text('Gender'),
              subtitle: Text(patient.gender),
              suffix: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  navigator.toDialog(NewPatientDialog());
                },
              ),
            ),
            FTile(
              title: Text('Records'),
              subtitle: Text('${records.length}'),
              suffix: FButton.icon(
                onPress: () => patientDetails.addMedicalRecordToPatient(
                  MedicalRecordModel(),
                ),
                child: const Icon(FIcons.plus),
              ),
            ),
            FTile(
              title: Text('Medical Records'),
              subtitle: Text('${records.length}'),
              suffix: FButton.icon(
                onPress: () => patientDetails.addMedicalRecordToPatient(
                  MedicalRecordModel(),
                ),
                child: const Icon(FIcons.plus),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
