import 'package:flutter/material.dart';
import 'package:hospital/application/departments/doctor_room/doctor_room.dart';

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

class Reception extends StatelessTab {
  const Reception({super.key});

  @override
  String get name => 'Reception';

  @override
  Widget build(BuildContext context) {
    return Text('Reception');
  }
}

class QueueProgressBar extends StatelessWidget {
  const QueueProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class ReceptionistInfobar extends StatelessWidget {
  const ReceptionistInfobar({super.key});

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
