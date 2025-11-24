import 'package:flutter/material.dart';
import 'package:hospital/domain/models/prescription.dart';
import 'package:hospital/features/departments/doctor_room/doctor_room.dart';
import 'package:hospital/utils/notifier.dart';
import 'package:hospital/utils/notifier_provider.dart';

class PharmacyNotifier extends Notifier {
  PharmacyNotifier(super.context);

  // Mock prescription data for demonstration
  final List<PrescriptionModel> prescriptions = [
    PrescriptionModel(
      id: 1,
      medicineName: 'Paracetamol',
      dosage: '500mg',
      frequency: 'Twice daily',
      endDate: DateTime.now().add(const Duration(days: 7)),
    ),
    PrescriptionModel(
      id: 2,
      medicineName: 'Amoxicillin',
      dosage: '250mg',
      frequency: 'Three times daily',
      endDate: DateTime.now().add(const Duration(days: 5)),
    ),
    PrescriptionModel(
      id: 3,
      medicineName: 'Lisinopril',
      dosage: '10mg',
      frequency: 'Once daily',
      endDate: DateTime.now().add(const Duration(days: 30)),
      notes: 'For blood pressure',
    ),
  ];

  int get pendingPrescriptions => prescriptions.length;
  int get completedPrescriptions => 0;

  void dispenseMedication(PrescriptionModel prescription) {
    // Logic for dispensing medication
  }

  void viewPrescriptionDetails(PrescriptionModel prescription) {
    // Logic for viewing prescription details
  }
}

class PharmacyRoom extends StatelessTab {
  const PharmacyRoom({super.key});

  @override
  String get name => 'Pharmacy Room';

  @override
  Widget build(BuildContext context) {
    return NotifierProvider(
      create: PharmacyNotifier.new,
      builder: (context, notifier) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Pharmacy Room'),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          body: Column(
            children: [
              // Pharmacy Status Header
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.red.shade100,
                child: Column(
                  children: [
                    const Text(
                      'Pharmacy Status',
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
                          'Pending',
                          '${notifier.pendingPrescriptions}',
                          Colors.orange,
                        ),
                        _buildStatusCard(
                          'Completed',
                          '${notifier.completedPrescriptions}',
                          Colors.green,
                        ),
                        _buildStatusCard(
                          'Total',
                          '${notifier.prescriptions.length}',
                          Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Prescription List Section
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Prescriptions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Prescription List
              Expanded(
                child: notifier.prescriptions.isEmpty
                    ? const Center(
                        child: Text(
                          'No prescriptions pending',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        itemCount: notifier.prescriptions.length,
                        itemBuilder: (context, index) {
                          final prescription = notifier.prescriptions[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: ListTile(
                              leading: const CircleAvatar(
                                backgroundColor: Colors.red,
                                child: Icon(
                                  Icons.description,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(prescription.medicineName),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${prescription.dosage} - ${prescription.frequency}',
                                  ),
                                  Text(
                                    'End Date: ${prescription.endDate.toString().split(' ')[0]}',
                                  ),
                                ],
                              ),
                              trailing: ElevatedButton(
                                onPressed: () =>
                                    notifier.dispenseMedication(prescription),
                                child: const Text('Dispense'),
                              ),
                              onTap: () => notifier.viewPrescriptionDetails(
                                prescription,
                              ),
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
}
