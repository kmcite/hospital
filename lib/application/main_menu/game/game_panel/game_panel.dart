import 'package:flutter/material.dart';

import '../../../departments/departments_screen.dart';
import '../../../statistics.dart';

class GamePanel extends StatelessWidget {
  const GamePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: StatisticsScreen()),
        DepartmentsScreen(),
      ],
    );
  }
}
