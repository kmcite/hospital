import 'dart:async' show Timer;

import 'package:flutter_rearch/flutter_rearch.dart';
import 'package:rearch/rearch.dart';

import '../main_menu/main_menu.dart';
import 'package:hospital/main.dart';

/// this screen is used to show a splash screen
/// it will navigate to the main menu screen after 2 seconds
/// well its purpose is to load resources and maybe show progress indecator.

// class SplashNotifier extends ChangeNotifier {
//   final BuildContext context;

//   Timer? _timer;
//   double progress = 0;

//   SplashNotifier(this.context) {
//     _timer = Timer.periodic(
//       const Duration(milliseconds: 200),
//       (timer) {
//         progress += 0.1;
//         notifyListeners();
//         if (progress >= 1) {
//           timer.cancel();
//           // navigator.to(MainMenuScreen());
//         }
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
// }

class SplashScreen extends RearchConsumer {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, use) {
    final progress = use(progressCapsule);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          spacing: 16,
          children: [
            Text(
              'Hospital',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            FDeterminateProgress(value: progress.clamp(0, 1)),
          ],
        ),
      ),
    );
  }
}

double progressCapsule(CapsuleHandle use) {
  final (progress, setProgress) = use.state<double>(0);

  use.effect(
    () {
      const totalTicks = 10; // 10 ticks → 20 seconds total
      int tick = 0;

      final timer = Timer.periodic(const Duration(milliseconds: 200), (t) {
        tick++;
        setProgress(tick / totalTicks);

        if (tick >= totalTicks) {
          t.cancel();
          navigator.to(MainMenuScreen());
        }
      });

      return () => timer.cancel();
    },
    [],
  ); // run only once on mount

  return progress;
}
