import 'package:hospital/hospital/patients/admitted/admitted_patients_repository.dart';
import 'package:hospital/hospital/patients/flow_repository.dart';
import 'package:hospital/hospital/patients/patient.dart';
import 'package:hospital/main.dart';

final waitingPatientsBlocRM = RM.inject(() => WaitingPatientsBloc());
WaitingPatientsBloc get waitingPatientsBloc => waitingPatientsBlocRM.state;

class WaitingPatientsBloc {
  AdmittedPatientsRepository get admittedPatientsRepository =>
      admittedPatientsRepositoryRM.state;
  final waitingPatientsRM = RM.inject(() => <Patient>[]);

  List<Patient> get waitingPatients => waitingPatientsRM.state;

  set waitingPatients(List<Patient> value) {
    waitingPatientsRM.state = List.of(value);
  }

  Patient get flow => flowRM.state;
  late final flowRM = RM.injectStream<Patient>(
    () => flowRepositoryRM.state.flow(),
    initialState: Patient(),
    sideEffects: SideEffects.onData(
      (p) {
        waitingPatients = List.of(waitingPatients)..add(p);
      },
    ),
  );

  admitPatient(Patient p) {
    waitingPatients = List.of(waitingPatients)..remove(p);
    admittedPatientsRepository.admitPatient(p);
  }

  void refer(Patient patient) {}
}
