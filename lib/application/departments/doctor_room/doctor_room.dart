import 'package:flutter/material.dart';
import 'package:hospital/application/departments/departments_screen.dart';

abstract class StatelessTab extends StatelessWidget with TabName {
  const StatelessTab({super.key});
}

class DoctorRoom extends StatelessTab {
  const DoctorRoom({super.key});

  @override
  String get name => 'Doctor Room';

  @override
  Widget build(BuildContext context) {
    return Text('Doctor Room');
  }
}
