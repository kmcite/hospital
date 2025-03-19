import 'dart:math';
import 'package:hospital/domain/models/flow.dart';
import 'package:hospital/main.dart';

import '../models/patient.dart';

final flowRepository = FlowRepository();

class FlowRepository {
  FlowRepository() {
    _startCountdown();
    _startPatientTimers(); // Start the patient timers to decrease remaining time.
  }
  Timer? _countdownTimer;
  Timer? _elapsedTimer;
  Timer? _patientTimer;
  final List<double> speedLevels = [0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5];

  final flowStateRM = RM.inject(() => FlowState());
  FlowState get flowState => flowStateRM.state;

  set flowState(FlowState value) {
    flowStateRM.state = value;
  }

  /// Starts the countdown timer for patient flow.
  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(
      Duration(milliseconds: (1000 / flowState.speedMultiplier).toInt()),
      (_) {
        if (!flowState.isRunning) return;

        if (flowState.countdownRemaining > 0) {
          flowState = flowState..countdownRemaining -= 1;
        } else {
          final newPatient = _generatePatient();
          flowState = flowState..patients[newPatient.id] = newPatient;
          _resetCountdown();
        }
      },
    );
  }

  /// Starts a timer that decrements remaining time for all patients every second.
  void _startPatientTimers() {
    _patientTimer?.cancel();
    _patientTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!flowState.isRunning) return;

        final updatedPatients = Map<int, Patient>.from(flowState.patients);
        final List<int> patientsToRemove = [];

        // ignore: unused_local_variable
        for (final patient in updatedPatients.values) {
          if (patient.remainingTime > 0) {
            updatedPatients[patient.id] = patient
              ..remainingTime = patient.remainingTime - 1;
          } else if (!patient.isAdmitted) {
            patientsToRemove.add(patient.id); // Collect IDs to remove later
          }
        }

        for (var id in patientsToRemove) {
          updatedPatients.remove(id);
        }

        flowState = flowState..patients = updatedPatients;
      },
    );
  }

  /// Generates a new patient with random properties.
  Patient _generatePatient() {
    // final id = faker.guid.guid();
    // final random = Random();

    return Patient(
        // id: id,
        // name: faker.person.name(),
        // symptom: faker.lorem.words(2).join(' '),
        // admissionTime: flowState.elapsedTime,
        // remainingTime: random.nextInt(10) + 5, // Random between 5-15 seconds
        // isEmergency: random.nextBool(),
        // canPay: random.nextBool(),
        // satisfaction: random.nextDouble(),
        // urgency: Urgency.values[random.nextInt(Urgency.values.length)],
        // isAdmitted: false,
        // isAlive: true,
        // status: Status.waiting,
        // investigations: [],
        );
  }

  /// Resets countdown with a new random duration.
  void _resetCountdown() {
    flowState = flowState
      ..countdownTotal = Random().nextInt(11) + 5
      ..countdownRemaining = flowState.countdownTotal;
  }

  /// Tracks elapsed time since the game started.
  void _trackElapsedTime() {
    _elapsedTimer?.cancel();
    _elapsedTimer = Timer.periodic(
      Duration(milliseconds: (1000 / flowState.speedMultiplier).toInt()),
      (_) {
        if (!flowState.isRunning) return;
        flowState = flowState..elapsedTime += 1;
      },
    );
  }

  /// Starts the flow.
  void start() {
    if (flowState.isRunning) return;

    flowState = flowState..isRunning = true;
    _trackElapsedTime();
    _startPatientTimers(); // Ensure patient countdown starts
  }

  /// Pauses the flow.
  void pause() {
    flowState = flowState..isRunning = false;
    _elapsedTimer?.cancel();
  }

  /// Cycles through predefined speed levels without resetting countdown.
  void toggleSpeed() {
    final currentIndex = speedLevels.indexOf(flowState.speedMultiplier);
    flowState = flowState
      ..speedMultiplier = (currentIndex == speedLevels.length - 1)
          ? speedLevels.first
          : speedLevels[currentIndex + 1];

    _restartTimers();
  }

  /// Sets a custom speed for patient flow.
  void changeSpeed(double newSpeed) {
    if (newSpeed <= 0) return;
    flowState = flowState..speedMultiplier = newSpeed;
    _restartTimers();
  }

  /// Restarts countdown and elapsed time timers with updated speed.
  void _restartTimers() {
    _countdownTimer?.cancel();
    _elapsedTimer?.cancel();
    _startCountdown();
    _trackElapsedTime();
    _startPatientTimers();
  }

  /// Removes a patient using their ID.
  void removePatient(int patientId) {
    if (!flowState.patients.containsKey(patientId)) return;
    flowState = flowState..patients.remove(patientId);
  }

  /// Stops the flow system.
  void stopFlow() {
    _countdownTimer?.cancel();
    _elapsedTimer?.cancel();
    _patientTimer?.cancel();
  }
}
