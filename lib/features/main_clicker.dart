import 'package:flutter/material.dart';
import 'package:hospital/business/clicker.dart';
import 'package:hospital/utils/sm.dart';

final class MainClicker extends UI {
  final ClickerProvider clicker;
  const MainClicker({required this.clicker});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Material(
      color: color.primary,
      shape: const CircleBorder(),
      elevation: 10,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          clicker.clickerTapped();
        },
        child: SizedBox(
          width: 180,
          height: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.health_and_safety, size: 64, color: color.onPrimary),
              const SizedBox(height: 8),
              Text(
                'Click',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: color.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
