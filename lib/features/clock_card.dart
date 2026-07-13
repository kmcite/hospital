import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

final class ClockCard extends SignalConsumer {
  const ClockCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Icon(
          //   isDay ? Icons.wb_sunny : Icons.nightlight_round,
          //   size: 48,
          // ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   '${clock.phaseText} - ${clock.timeText}',
                //   style: Theme.of(context).textTheme.headlineSmall,
                // ),
                // const SizedBox(height: 4),
                // Text(
                //   'Passed: ${clock.ageText}',
                //   style: Theme.of(context).textTheme.bodyLarge,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
