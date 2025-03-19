import 'package:forui/forui.dart';
import 'package:hospital/domain/api/patients_repository.dart';
import 'package:hospital/features/waiting/waiting_patient_page.dart';
import 'package:hospital/main.dart';
import 'package:hospital/navigator.dart';

import '../../domain/models/patient.dart';

Patient recentlyAdded = Patient();
mixin WaitingPatientsBloc {
  bool get isPatientsFlowEmpty =>
      patientsRepository.getPatientsByStatus().isEmpty;
}

class WaitingPatientsPage extends UI with WaitingPatientsBloc {
  const WaitingPatientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text('Waiting Patients'),
        prefixActions: [
          FHeaderAction.back(onPress: navigator.back),
        ],
      ),
      content: isPatientsFlowEmpty
          ? Text('no patients are waiting').center()
          : WaitingPatientsGrid(),
    );
  }
}

mixin WaitingPatientsGridBloc {
  Iterable<Patient> get patients => patientsRepository.getPatientsByStatus();
  void details(Patient patient) {
    waitingPatientBloc.state = patient;
    navigator.to(WaitingPatientPage());
  }
}

class WaitingPatientsGrid extends UI with WaitingPatientsGridBloc {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      content: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 3 / 4,
        ),
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients.elementAt(index);
          return WaitingPatientGrid(
            patient: patient,
            onTap: () => details(patient),
          );
        },
      ),
    );
  }
}

mixin WaitingPatientGridBloc {
  void admitPatient(Patient patient) {
    // flowRepository.removePatient(patient.id);
    // patientsRepository.put(patient.copyWith(status: Status.admitted));
  }
  void refer(Patient patient) {
    // flowRepository.removePatient(patient.id);
  }
}

class WaitingPatientGrid extends UI with WaitingPatientGridBloc {
  final Patient patient;
  final void Function()? onTap;

  const WaitingPatientGrid({
    super.key,
    required this.patient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FTappable(
      onPress: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Emergency indicator
          FIcon(
            patient.isEmergency
                ? FAssets.icons.aArrowDown
                : FAssets.icons.aArrowUp,
            size: 30,
          ),
          const SizedBox(height: 8),
          Text(
            patient.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),

          Text(
            'time: ${patient.remainingTime} seconds',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            'Satisfaction: ${patient.satisfaction.toStringAsFixed(1)}%',
            style: const TextStyle(fontSize: 14, color: Colors.green),
          ),
          Row(
            children: [
              FButton.icon(
                onPress: () {
                  admitPatient(patient);
                },
                child: FIcon(
                  FAssets.icons.checkCheck,
                ),
              ),
              FButton.icon(
                onPress: () {
                  refer(patient);
                },
                child: FIcon(FAssets.icons.octagon),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
