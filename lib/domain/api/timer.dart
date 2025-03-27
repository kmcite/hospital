import 'dart:async';

final timerRepository = TimerRepository();

class TimerRepository {
  Timer? _timer;
  int _currentTime = 0;

  void periodic(
    Duration interval,
    void Function() onTick,
  ) {
    _timer?.cancel();
    _timer = Timer.periodic(interval, (timer) {
      _currentTime++;
      onTick();
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  int get currentTime => _currentTime;
}
