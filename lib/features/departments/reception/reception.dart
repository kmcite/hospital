import 'package:flutter/material.dart';
import 'package:hospital/features/common/department_detail_view.dart';
import 'package:hospital/features/common/patient_tile.dart';
import 'package:hospital/domain/models/patient.dart';
import 'package:hospital/features/departments/doctor_room/doctor_room.dart';
import 'package:hospital/features/departments/reception/patient_details.dart';
import 'package:hospital/utils/notifier.dart';
import 'package:hospital/utils/notifier_provider.dart';
import 'package:hospital/utils/navigator.dart';

//  │       ├── ReceptionView
//  │       │   ├── Patient Queue List
//  │       │   │   ├── PatientTile (symptoms, timers, urgency)
//  │       │   │   └── PatientDetailsPage
//  │       │   │       ├── Vitals
//  │       │   │       ├── Symptoms List
//  │       │   │       ├── Investigations
//  │       │   │       ├── Treatment Options
//  │       │   │       └── Satisfaction Meter
//  │       │   ├── Receptionist Info Bar
//  │       │   ├── Queue Progress Bar
//  │       │   └── Patient Queue Status

class ReceptionNotifier extends Notifier {
  ReceptionNotifier(super.context);

  // Mock patient data for demonstration
  final List<PatientModel> patients = [
    PatientModel(
      id: 1,
      name: 'John Doe',
      age: 45,
      gender: 'Male',
    ),
    PatientModel(
      id: 2,
      name: 'Jane Smith',
      age: 32,
      gender: 'Female',
    ),
    PatientModel(
      id: 3,
      name: 'Robert Johnson',
      age: 67,
      gender: 'Male',
    ),
  ];

  int get patientCount => patients.length;
  int get waitingCount => patients.length;
  int get inProgressCount => 0;
  int get completedCount => 0;

  void viewPatientDetails(BuildContext context, PatientModel patient) {
    navigator.to(PatientDetailsPage(patient: patient));
  }
}

class Reception extends StatelessTab {
  const Reception({super.key});

  @override
  String get name => 'Reception';

  @override
  Widget build(BuildContext context) {
    return NotifierProvider(
      create: ReceptionNotifier.new,
      builder: (context, notifier) {
        return DepartmentDetailView(
          title: 'Reception',
          color: Colors.blue,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // Add new patient functionality
              },
            ),
          ],
          header: DepartmentHeader(
            title: 'Reception',
            subtitle: 'Patient Queue Management',
            icon: Icons.person,
            color: Colors.blue,
          ),
          children: [
            // Queue Status Cards
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  DepartmentStatCard(
                    label: 'Waiting',
                    value: '${notifier.waitingCount}',
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 16),
                  DepartmentStatCard(
                    label: 'In Progress',
                    value: '${notifier.inProgressCount}',
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 16),
                  DepartmentStatCard(
                    label: 'Completed',
                    value: '${notifier.completedCount}',
                    color: Colors.green,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Queue Progress Bar
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Queue Progress',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: notifier.waitingCount > 0
                          ? notifier.completedCount / notifier.patientCount
                          : 0,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Patient flow status',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Patient Queue List Title
            const Text(
              'Patient Queue',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // Patient Queue List
            notifier.patients.isEmpty
                ? const Center(
                    child: Text(
                      'No patients in queue',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : Column(
                    children: [
                      for (int i = 0; i < notifier.patients.length; i++)
                        PatientTile(
                          name: notifier.patients[i].name,
                          age: notifier.patients[i].age,
                          gender: notifier.patients[i].gender,
                          recordCount:
                              notifier.patients[i].medicalRecords.length,
                          onTap: () => notifier.viewPatientDetails(
                            context,
                            notifier.patients[i],
                          ),
                        ),
                    ],
                  ),
          ],
        );
      },
    );
  }
}
