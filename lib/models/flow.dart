import 'patient.dart';

/// Holds current state of the flow system.
class FlowState {
  int countdownRemaining = 0; // Time left before adding next patient.
  int countdownTotal = 5; // Countdown duration.
  double speedMultiplier = 1.0; // Speed of patient flow.
  bool isRunning = false; // Tracks whether flow is active.
  int elapsedTime = 0; // Total time since flow started.
  Map<int, Patient> patients = {}; // Stores patients by ID.

  FlowState();
}
