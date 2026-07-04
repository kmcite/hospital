import 'dart:async' show Timer;
import 'dart:developer' show log;
import 'package:hospital/domain/clock_model.dart';
import 'package:hospital/utils/di.dart';
import 'package:hospital/utils/sm.dart';

final gameRepository = provider((ref) => GameRepository());

class GameRepository {
  final clockSignal = signal(ClockModel());
  final savegameSignal = signal(false);
  final continueGameSignal = signal(false);
  final clicksSignal = signal(0);
  void incrementClicks() {
    clicksSignal((value) => value + 1);
    log('incrementClicks', name: this.runtimeType.toString());
  }

  Timer? _timer;
  void startGame() {
    continueGameSignal.state = false;
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => clockSignal((value) => value.advance()),
    );
  }

  void pauseGame() {
    _timer?.cancel();
    continueGameSignal.state = true;
  }
}
