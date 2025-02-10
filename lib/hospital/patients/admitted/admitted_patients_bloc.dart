import 'package:hospital/hospital/patients/admitted/admitted_patients_repository.dart';
import 'package:hospital/hospital/patients/patient.dart';
import 'package:hospital/main.dart';

class AdmittedPatientsBloc {
  List<Patient> get admittedPatients {
    return admittedPatientsRepositoryRM.state.patients;
  }

  dischargePatient(Patient p) =>
      admittedPatientsRepositoryRM.state.dischargePatient(p);
}

final admittedPatientsBlocRM = RM.inject(() => AdmittedPatientsBloc());
AdmittedPatientsBloc get admittedPatientsBloc => admittedPatientsBlocRM.state;
