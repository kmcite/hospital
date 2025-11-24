import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:hospital/features/main_menu/main_menu.dart';
import 'package:hospital/utils/notifier.dart';
import 'package:hospital/utils/notifier_provider.dart';
import 'package:hospital/utils/navigator.dart';

/// this screen is used to show a splash screen
/// it will navigate to the main menu screen after 2 seconds
/// well its purpose is to load resources and maybe show progress indicator.

class SplashNotifier extends Notifier {
  double _progress = 0;
  Timer? _timer;

  SplashNotifier(super.context) {
    _startTimer();
  }

  double get progress => _progress;

  void _startTimer() {
    const totalTicks = 10; // 10 ticks → 20 seconds total
    int tick = 0;

    _timer = Timer.periodic(const Duration(milliseconds: 200), (t) {
      tick++;
      _progress = tick / totalTicks;
      notifyListeners();

      if (tick >= totalTicks) {
        t.cancel();
        navigator.toReplacement(const MainMenuScreen());
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NotifierProvider(
      create: SplashNotifier.new,
      builder: (context, splash) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                Icon(
                  Icons.local_hospital,
                  size: 100,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Text(
                  'Hospital',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                  ),
                ),
                LinearProgressIndicator(
                  value: splash.progress.clamp(0, 1),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
