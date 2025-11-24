import 'package:flutter/material.dart';

/// A reusable component for displaying patient information
class PatientTile extends StatelessWidget {
  final String name;
  final int age;
  final String gender;
  final int recordCount;
  final VoidCallback? onTap;

  const PatientTile({
    super.key,
    required this.name,
    required this.age,
    required this.gender,
    required this.recordCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text(name),
        subtitle: Text('Age: $age | Gender: $gender'),
        trailing: Text('$recordCount records'),
        onTap: onTap,
      ),
    );
  }
}
