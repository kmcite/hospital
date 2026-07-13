import 'package:flutter/material.dart';
import 'package:hospital/apis/events.dart';
import 'package:hospital/business/hospital.dart';
import 'package:hospital/business/patients.dart';
import 'package:hospital/utils/messaging.dart';
import 'package:hospital/utils/provider.dart';
import 'package:signals/signals.dart';

class GameScreen extends SignalConsumer {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final patients = context.of(patientsProvider);
    final receptionist = context.of(receptionistRM);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${receptionist.money().toInt()}'),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Fees: ${receptionist.patientFee().toInt()}/pt'),
                ),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _SmallStat(
                      icon: Icons.star,
                      title: 'Score',
                      value: '0',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SmallStat(
                      icon: Icons.person,
                      title: 'Patients',
                      value: '0',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              _SmallStat(
                icon: Icons.auto_mode,
                title: 'Auto Treat',
                value: '0/sec',
              ),

              const Spacer(),

              Icon(
                Icons.local_hospital,
                size: 120,
                color: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: 32),

              FilledButton(
                onPressed: patients.canPatientBeTreated()
                    ? () => send(PatientTreated())
                    : null,
                child: const Text(
                  'ASSESS PATIENT',
                  style: TextStyle(fontSize: 32),
                ),
              ),

              const SizedBox(height: 32),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Patients Waiting'),
                      Text(
                        '${patients.patients()}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SmallStat extends StatelessWidget {
  const _SmallStat({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Expanded(
              child: Text(title),
            ),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
