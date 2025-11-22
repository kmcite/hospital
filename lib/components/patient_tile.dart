import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

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
    return FTile(
      title: Text(name),
      subtitle: Text('Age: $age | Gender: $gender'),
      suffix: Text('$recordCount records'),
      onPress: onTap,
    );
  }
}
