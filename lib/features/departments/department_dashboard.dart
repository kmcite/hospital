import 'package:flutter/material.dart';
import 'package:hospital/features/common/department_card.dart';
import 'package:hospital/features/departments/doctor_room/doctor_room.dart';
import 'package:hospital/features/departments/minor_ot.dart';
import 'package:hospital/features/departments/pharmacy/pharmacy_room.dart';
import 'package:hospital/features/departments/reception/reception.dart';
import 'package:hospital/features/departments/staff_room/staff_room.dart';
import 'package:hospital/features/departments/ward/ward.dart';
import 'package:hospital/utils/navigator.dart';

class DepartmentDashboard extends StatelessWidget {
  const DepartmentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital Departments'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            DepartmentCardComponent(
              title: 'Reception',
              icon: Icons.person,
              color: Colors.blue,
              onTap: () => navigator.to(const Reception()),
            ),
            DepartmentCardComponent(
              title: 'Doctor Room',
              icon: Icons.local_hospital,
              color: Colors.green,
              onTap: () => navigator.to(const DoctorRoom()),
            ),
            DepartmentCardComponent(
              title: 'Ward',
              icon: Icons.bed,
              color: Colors.purple,
              onTap: () => navigator.to(const Ward()),
            ),
            DepartmentCardComponent(
              title: 'Minor OT',
              icon: Icons.cut,
              color: Colors.orange,
              onTap: () => navigator.to(const MinorOT()),
            ),
            DepartmentCardComponent(
              title: 'Pharmacy',
              icon: Icons.local_pharmacy,
              color: Colors.red,
              onTap: () => navigator.to(const PharmacyRoom()),
            ),
            DepartmentCardComponent(
              title: 'Staff Room',
              icon: Icons.people,
              color: Colors.indigo,
              onTap: () => navigator.to(const StaffRoom()),
            ),
          ],
        ),
      ),
    );
  }
}
