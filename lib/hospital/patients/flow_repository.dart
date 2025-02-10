import 'dart:developer';

import 'package:hospital/hospital/patients/patient.dart';
import 'package:hospital/main.dart';

import '../resources/resources.dart';

final flowRepositoryRM = RM.inject(() => FlowRepository());

class FlowRepository {
  final _controller = StreamController<Patient>.broadcast();
  Timer? _timer;

  FlowRepository() {
    _startFlow();
  }

  void _startFlow() {
    const interval = Duration(seconds: 5); // Emit a patient every 5 seconds.
    _timer = Timer.periodic(
      interval,
      (_) {
        final newPatient = Patient(); // Generate a new Patient.
        log('New Patient Added: ${newPatient.symptom}');
        _controller.add(newPatient);
      },
    );
  }

  Stream<Patient> flow() => _controller.stream;

  void stopFlow() {
    _timer?.cancel();
    _controller.close();
  }
}

class PatientFlow {
  List<Patient> waitingQueue = [];
  List<Patient> admittedPatients = [];
  List<Patient> daycarePatients = [];

  void addPatient(Patient patient) {
    waitingQueue.add(patient);
  }

  void admitPatient(Resources resources) {
    if (resources.availableBeds > 0 && waitingQueue.isNotEmpty) {
      var patient = waitingQueue.removeAt(0)..isAdmitted = true;
      admittedPatients.add(patient);
      resources.availableBeds--;
    }
  }

  void dischargePatient(Patient patient, Resources resources) {
    admittedPatients.remove(patient);
    resources.availableBeds++;
  }
}
