import 'package:flutter/material.dart';
import 'package:hospital/application/departments/staff_room/staff_card.dart';
import 'package:hospital/domain/models/staff.dart';

class StaffList extends StatelessWidget {
  final List<StaffModel> staff;

  const StaffList({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: staff.length,
      itemBuilder: (context, index) => StaffCard(staff: staff[index]),
    );
  }
}
