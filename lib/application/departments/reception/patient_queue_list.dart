import 'package:flutter/material.dart';

//  │       │   ├── Patient Queue List
//  │       │   │   ├── PatientTile (symptoms, timers, urgency)
//  │       │   │   └── PatientDetailsPage
//  │       │   │       ├── Vitals
//  │       │   │       ├── Symptoms List
//  │       │   │       ├── Investigations
//  │       │   │       ├── Treatment Options
//  │       │   │       └── Satisfaction Meter

class PatientQueueList extends StatelessWidget {
  const PatientQueueList({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList.list(
          children: [
            _PatientTile(),
          ],
        ),
      ],
    );
  }
}

class _PatientTile extends StatelessWidget {
  const _PatientTile({super.key});

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
