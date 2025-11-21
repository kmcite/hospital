import 'package:flutter/material.dart';
import 'package:hospital/application/departments/doctor_room/doctor_room.dart';

class Ward extends StatelessTab {
  const Ward({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Ward');
  }

  @override
  String get name => 'Ward';
}
