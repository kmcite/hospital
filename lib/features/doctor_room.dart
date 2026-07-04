import 'package:flutter/material.dart';

class DoctorRoomScreen extends StatefulWidget {
  const DoctorRoomScreen({super.key});

  @override
  State<DoctorRoomScreen> createState() => _DoctorRoomScreenState();
}

class _DoctorRoomScreenState extends State<DoctorRoomScreen> {
  String? currentPatient;
  double progress = 0.0;
  String status = 'Room empty';

  final waitingPatients = <String>[
    'Patient #001',
    'Patient #002',
    'Patient #003',
    'Patient #004',
  ];

  void callNextPatient() {
    if (waitingPatients.isEmpty) return;

    setState(() {
      currentPatient = waitingPatients.removeAt(0);
      progress = 0.0;
      status = 'Patient called';
    });
  }

  void treatPatient() {
    if (currentPatient == null) return;

    setState(() {
      progress += 0.25;

      if (progress >= 1.0) {
        progress = 1.0;
        status = 'Treatment complete';
      } else {
        status = 'Treatment in progress';
      }
    });
  }

  void discharge(String destination) {
    if (currentPatient == null || progress < 1.0) return;

    setState(() {
      status = '$currentPatient discharged to $destination';
      currentPatient = null;
      progress = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasPatient = currentPatient != null;
    final completed = progress >= 1.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Icon(Icons.medical_services, size: 56),
                    const SizedBox(height: 12),

                    Text(
                      currentPatient ?? 'No patient inside',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    const SizedBox(height: 8),

                    Text(status),

                    const SizedBox(height: 16),

                    LinearProgressIndicator(value: progress),

                    const SizedBox(height: 8),

                    Text('${(progress * 100).toInt()}% treated'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: hasPatient ? null : callNextPatient,
                    icon: const Icon(Icons.call),
                    label: const Text('Call Patient'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: hasPatient && !completed ? treatPatient : null,
                    icon: const Icon(Icons.healing),
                    label: const Text('Treat'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Card(
              child: Column(
                children: [
                  const ListTile(
                    title: Text('Discharge Patient'),
                    subtitle: Text('Available after treatment is complete'),
                  ),

                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: completed ? () => discharge('Home') : null,
                        child: const Text('Home'),
                      ),
                      OutlinedButton(
                        onPressed: completed ? () => discharge('Ward') : null,
                        child: const Text('Ward'),
                      ),
                      OutlinedButton(
                        onPressed: completed
                            ? () => discharge('Referral')
                            : null,
                        child: const Text('Referral'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: Card(
                child: Column(
                  children: [
                    const ListTile(
                      title: Text('Waiting Patients'),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: waitingPatients.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(waitingPatients[index]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
