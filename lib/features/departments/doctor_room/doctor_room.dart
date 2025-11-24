import 'package:flutter/material.dart';
import 'package:hospital/domain/models/patient.dart';
import 'package:hospital/domain/models/staff.dart';
import 'package:hospital/utils/notifier.dart';
import 'package:hospital/utils/notifier_provider.dart';

mixin TabName {
  String get name;
}

abstract class StatelessTab extends StatelessWidget with TabName {
  const StatelessTab({super.key});
}

class DoctorRoomNotifier extends Notifier {
  DoctorRoomNotifier(super.context);

  // Mock data for demonstration
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
  ];

  final StaffModel doctor = StaffModel(
    id: 1,
    name: 'Dr. Michael Chen',
    role: 'Cardiologist',
    department: 'Cardiology',
    contactNumber: '+1234567890',
    email: 'michael.chen@hospital.com',
  );

  void diagnosePatient(PatientModel patient) {
    // Logic for diagnosing patient
  }

  void prescribeMedication(PatientModel patient) {
    // Logic for prescribing medication
  }
}

class DoctorRoom extends StatelessTab {
  const DoctorRoom({super.key});

  @override
  String get name => 'Doctor Room';

  @override
  Widget build(BuildContext context) {
    return NotifierProvider(
      create: DoctorRoomNotifier.new,
      builder: (context, notifier) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Doctor Room'),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          body: Column(
            children: [
              // Doctor Information Header
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.green.shade100,
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.local_hospital,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notifier.doctor.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${notifier.doctor.role} - ${notifier.doctor.department}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Add consultation functionality
                      },
                      child: const Text('New Consultation'),
                    ),
                  ],
                ),
              ),

              // Patient List Section
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Patients',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Patient List
              Expanded(
                child: notifier.patients.isEmpty
                    ? const Center(
                        child: Text(
                          'No patients assigned',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        itemCount: notifier.patients.length,
                        itemBuilder: (context, index) {
                          final patient = notifier.patients[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: ListTile(
                              leading: const CircleAvatar(
                                backgroundColor: Colors.green,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(patient.name),
                              subtitle: Text(
                                '${patient.age} years, ${patient.gender}',
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.description),
                                    onPressed: () =>
                                        notifier.diagnosePatient(patient),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.table_chart),
                                    onPressed: () =>
                                        notifier.prescribeMedication(patient),
                                  ),
                                ],
                              ),
                              onTap: () {
                                // View patient details
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
