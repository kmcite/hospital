import 'package:flutter/material.dart';
import 'package:hospital/business/patient_arrival.dart';
import 'package:hospital/utils/provider.dart';
import 'package:signals/signals.dart';

final class MainClicker extends SignalConsumer {
  const MainClicker({super.key});

  @override
  Widget build(BuildContext context) {
    final patientArrival = context.of(patientArrivalProvider);
    final color = Theme.of(context).colorScheme;

    return Material(
      color: color.primary,
      shape: const CircleBorder(),
      elevation: 10,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {},
        child: SizedBox(
          width: 180,
          height: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.health_and_safety, size: 64, color: color.onPrimary),
              const SizedBox(height: 8),
              Text(
                'Click=[${patientArrival.clicks()}]',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: color.onPrimary,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
