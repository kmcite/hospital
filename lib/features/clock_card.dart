import 'package:flutter/material.dart';
import 'package:hospital/business/hospital.dart';
import 'package:hospital/domain/clock_model.dart';
import 'package:hospital/utils/sm.dart';

final class ClockCard extends UI {
  final HospitalProvider hospital;
  const ClockCard({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    final clock = hospital.clockSignal();
    final isDay = clock.phase == DayPhase.day;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(
              isDay ? Icons.wb_sunny : Icons.nightlight_round,
              size: 48,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${clock.phaseText} - ${clock.timeText}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Passed: ${clock.ageText}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
