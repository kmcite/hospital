import 'package:flutter/material.dart';
import 'package:hospital/main.dart';
import 'package:hospital/models/patient.dart';
import 'package:hospital/navigator.dart';
import 'package:hospital/ui/admitted/admitted_patients_page.dart';

mixin WaitingPatientBloc {
  Injected<Patient> get patient => selectedPatientRepository;
}

class WaitingPatientPage extends UI with WaitingPatientBloc {
  const WaitingPatientPage({super.key});

  @override
  Widget build(context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(patient.state.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: navigator.back,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Patient Details',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Name'),
                      subtitle: Text(patient.state.name),
                    ),
                    ListTile(
                      leading: const Icon(Icons.timer),
                      title: const Text('Admission Time'),
                      subtitle: Text('${patient.state.admissionTime} minutes'),
                    ),
                    ListTile(
                      leading: Icon(
                        patient.state.canPay
                            ? Icons.attach_money
                            : Icons.money_off,
                        color: patient.state.canPay ? Colors.green : Colors.red,
                      ),
                      title: const Text('Payment Status'),
                      subtitle:
                          Text(patient.state.canPay ? 'Can Pay' : 'Cannot Pay'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.health_and_safety),
                      title: const Text('Urgency'),
                      subtitle: Text(patient.state.urgency.toString()),
                      tileColor:
                          patient.state.urgency == Urgency.lifeThreatening
                              ? Colors.red[50]
                              : patient.state.urgency == Urgency.critical
                                  ? Colors.orange[50]
                                  : Colors.green[50],
                    ),
                  ],
                ),
              ),
            ),
            if (patient.state.symptoms.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text(
                'Symptoms',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Card(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: patient.state.symptoms.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final symptom = patient.state.symptoms[index];
                    return ListTile(
                      title: Text(symptom.name),
                      subtitle: Text(symptom.description),
                      trailing: Chip(
                        label: Text('\$${symptom.cost}'),
                        backgroundColor: theme.colorScheme.secondaryContainer,
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
