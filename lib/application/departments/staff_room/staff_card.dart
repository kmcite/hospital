import 'package:flutter/material.dart';
import 'package:hospital/domain/models/staff.dart';

class StaffCard extends StatelessWidget {
  final StaffModel staff;
  const StaffCard({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(staff.name),
        subtitle: Text('${staff.role} | ${staff.department}'),
        trailing: Text(staff.isActive ? 'Active' : 'Inactive'),
        onTap: () {
          // Navigate to staff details
        },
      ),
    );
  }
}
