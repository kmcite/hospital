import 'package:hospital/main.dart';

final hospitalBlocRM = RM.inject(() => HospitalBloc());
HospitalBloc get hospitalBloc => hospitalBlocRM.state;

class HospitalBloc with ChangeNotifier {
  Timer? _timer;
  final timerStateRM = RM.inject(() => TimerState());

  TimerState get state => timerStateRM.state;

  // Accessors for convenience
  int get elapsedTime => state.elapsedTime;
  double get speedMultiplier => state.speedMultiplier;
  bool get isRunning => state.isRunning;

  // Predefined speed levels
  final List<double> speedLevels = [1, 2, 3, 4, 5];

  // Emits a new state
  void emit(TimerState state) => timerStateRM.state = state;

  void start() {
    if (state.isRunning) return;
    emit(state.copyWith(isRunning: true));
    _startTimer();
  }

  void pause() {
    _timer?.cancel();
    emit(state.copyWith(isRunning: false));
  }

  void toggleSpeed() {
    final currentIndex = speedLevels.indexOf(speedMultiplier);
    final newSpeed = (currentIndex == speedLevels.length - 1)
        ? speedLevels.first
        : speedLevels[currentIndex + 1];
    changeSpeed(newSpeed);
  }

  void changeSpeed(double newSpeed) {
    if (newSpeed <= 0) return; // Prevent invalid speeds.
    _timer?.cancel(); // Stop the existing timer.
    emit(state.copyWith(speedMultiplier: newSpeed));
    if (state.isRunning) {
      _startTimer(); // Restart timer with the new speed.
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(
      Duration(milliseconds: (1000 / state.speedMultiplier).toInt()),
      (_) {
        emit(state.copyWith(elapsedTime: state.elapsedTime + 1));
      },
    );
  }

  void reset() {
    _timer?.cancel();
    emit(TimerState(
      elapsedTime: 0,
      speedMultiplier: 1.0,
      isRunning: false,
    ));
  }

  void close() {
    _timer?.cancel();
    timerStateRM.disposeIfNotUsed();
  }
}

class TimerState {
  final int elapsedTime;
  final double speedMultiplier;
  final bool isRunning;

  TimerState({
    this.elapsedTime = 0,
    this.speedMultiplier = 1.0,
    this.isRunning = false,
  });

  TimerState copyWith({
    int? elapsedTime,
    double? speedMultiplier,
    bool? isRunning,
  }) {
    return TimerState(
      elapsedTime: elapsedTime ?? this.elapsedTime,
      speedMultiplier: speedMultiplier ?? this.speedMultiplier,
      isRunning: isRunning ?? this.isRunning,
    );
  }
}
