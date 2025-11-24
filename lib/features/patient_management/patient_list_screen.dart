import 'package:flutter/material.dart';
import 'package:hospital/domain/models/medical_record.dart';
import 'package:hospital/domain/models/patient.dart';
import 'package:hospital/features/home.dart';
import 'package:hospital/features/patient_management/patient_list_view.dart';

class PatientListScreen extends StatelessWidget {
  const PatientListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for demonstration
    final patients = [
      PatientWithRecords(
        patient: PatientModel(
          id: 1,
          name: 'John Doe',
          age: 35,
          gender: 'Male',
          registrationDate: DateTime.now().subtract(const Duration(days: 2)),
        ),
        records: [
          MedicalRecordModel()
            ..id = 1
            ..patientId = 1
            ..date = DateTime.now().subtract(const Duration(days: 1))
            ..diagnosis = 'Common Cold',
        ],
      ),
      PatientWithRecords(
        patient: PatientModel(
          id: 2,
          name: 'Jane Smith',
          age: 28,
          gender: 'Female',
          registrationDate: DateTime.now().subtract(const Duration(days: 1)),
        ),
        records: [],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Navigate to add new patient screen
            },
          ),
        ],
      ),
      body: PatientListView(
        patients: patients,
        onTap: (patientWithRecords) {
          // TODO: Navigate to patient details screen
        },
      ),
    );
  }
}
