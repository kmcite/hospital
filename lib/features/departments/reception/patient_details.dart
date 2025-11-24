import 'package:flutter/material.dart';
import 'package:hospital/domain/models/patient.dart';

class PatientDetailsPage extends StatelessWidget {
  final PatientModel patient;

  const PatientDetailsPage({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${patient.name} Details'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Patient Header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              patient.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${patient.age} years, ${patient.gender}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Registration Date: ${patient.registrationDate.toString().split(' ')[0]}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Vitals Section
            const SectionHeader(title: 'Vitals'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildVitalRow('Blood Pressure', '120/80 mmHg'),
                    const Divider(),
                    _buildVitalRow('Heart Rate', '72 bpm'),
                    const Divider(),
                    _buildVitalRow('Temperature', '98.6°F'),
                    const Divider(),
                    _buildVitalRow('Weight', '70 kg'),
                    const Divider(),
                    _buildVitalRow('Height', '175 cm'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Symptoms List
            const SectionHeader(title: 'Symptoms'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildSymptomChip('Headache'),
                    const SizedBox(height: 8),
                    _buildSymptomChip('Fever'),
                    const SizedBox(height: 8),
                    _buildSymptomChip('Fatigue'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Investigations
            const SectionHeader(title: 'Investigations'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildInvestigationRow('Complete Blood Count', 'Pending'),
                    const Divider(),
                    _buildInvestigationRow('X-Ray Chest', 'Normal'),
                    const Divider(),
                    _buildInvestigationRow('ECG', 'Completed'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Treatment Options
            const SectionHeader(title: 'Treatment Options'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Send to Doctor Room'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Schedule Appointment'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Prescribe Medication'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Satisfaction Meter
            const SectionHeader(title: 'Patient Satisfaction'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'Current Satisfaction Level',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: 0.7,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('70% Satisfied'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVitalRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSymptomChip(String symptom) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        symptom,
        style: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildInvestigationRow(String testName, String status) {
    Color statusColor = Colors.grey;
    if (status == 'Completed') {
      statusColor = Colors.green;
    } else if (status == 'Pending') {
      statusColor = Colors.orange;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          testName,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          status,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: statusColor,
          ),
        ),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
