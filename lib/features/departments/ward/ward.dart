import 'package:flutter/material.dart';
import 'package:hospital/domain/models/patient.dart';
import 'package:hospital/features/departments/doctor_room/doctor_room.dart';
import 'package:hospital/utils/notifier.dart';
import 'package:hospital/utils/notifier_provider.dart';

class WardNotifier extends Notifier {
  WardNotifier(super.context);

  // Mock patient data for demonstration
  final List<PatientModel> patients = [
    PatientModel(
      id: 1,
      name: 'Robert Johnson',
      age: 67,
      gender: 'Male',
    ),
    PatientModel(
      id: 2,
      name: 'Emily Davis',
      age: 28,
      gender: 'Female',
    ),
    PatientModel(
      id: 3,
      name: 'Thomas Wilson',
      age: 54,
      gender: 'Male',
    ),
  ];

  int get occupiedBeds => patients.length;
  int get totalBeds => 10;
  int get availableBeds => totalBeds - occupiedBeds;

  void dischargePatient(PatientModel patient) {
    // Logic for discharging patient
  }

  void viewPatientDetails(PatientModel patient) {
    // Logic for viewing patient details
  }
}

class Ward extends StatelessTab {
  const Ward({super.key});

  @override
  Widget build(BuildContext context) {
    return NotifierProvider(
      create: WardNotifier.new,
      builder: (context, notifier) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Ward'),
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
          ),
          body: Column(
            children: [
              // Ward Status Header
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.purple.shade100,
                child: Column(
                  children: [
                    const Text(
                      'Ward Status',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatusCard(
                          'Occupied',
                          '${notifier.occupiedBeds}',
                          Colors.red,
                        ),
                        _buildStatusCard(
                          'Available',
                          '${notifier.availableBeds}',
                          Colors.green,
                        ),
                        _buildStatusCard(
                          'Total',
                          '${notifier.totalBeds}',
                          Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Patient List Section
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Patients in Ward',
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
                          'No patients in ward',
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
                                backgroundColor: Colors.purple,
                                child: Icon(
                                  Icons.bed,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(patient.name),
                              subtitle: Text(
                                '${patient.age} years, ${patient.gender}',
                              ),
                              trailing: ElevatedButton(
                                onPressed: () =>
                                    notifier.dischargePatient(patient),
                                child: const Text('Discharge'),
                              ),
                              onTap: () => notifier.viewPatientDetails(patient),
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

  Widget _buildStatusCard(String label, String value, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  String get name => 'Ward';
}
