import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/domain/api/doctors.dart';
import 'package:hospital/domain/api/patient_repository.dart';
import 'package:hospital/domain/api/patients_repository.dart';
import 'package:hospital/domain/api/timer.dart';
import 'package:hospital/ui/core/funds_badge.dart';
import 'package:hospital/ui/waiting/waiting_patient_page.dart';
import 'package:hospital/main.dart';
import 'package:hospital/navigator.dart';

import '../../domain/models/patient.dart';

mixin WaitingPatientsBloc {
  Iterable<Patient> get patients {
    return patientsRepository.getPatientsByStatus();
  }

  void startAutomaticAdmissions() {
    timerRepository.periodic(
      4.seconds,
      () {
        final onDutyDoctors = doctorsRepository.doctorsOnDuty;
        if (onDutyDoctors.isNotEmpty) {
          for (final doctor in onDutyDoctors) {
            final patient =
                patientsRepository.getPatientsByStatus().firstOrNull;
            if (patient != null) {
              admit(patient..doctor.target = doctor);
            }
          }
          final waitingPatients = patientsRepository.getPatientsByStatus(
            Status.waiting,
          );
          for (final patient in waitingPatients) {
            admit(patient);
          }
        }
      },
    );
  }

  bool get isPatientsFlowEmpty => patients.isEmpty;

  void admit(Patient patient) {
    // settingsRepository.funds(50);
    patientsRepository.put(patient..status = Status.admitted);
  }

  void refer(Patient patient) {
    // settingsRepository.funds(-10);
    patientsRepository.put(patient..status = Status.referred);
    patientsRepository.remove(patient.id);
  }

  void remove(Patient patient) {
    patientsRepository.remove(patient.id);
  }

  Modifier<Patient> get patient => patientRepository;

  void details(Patient _patient) {
    patient(_patient);
    navigator.to(WaitingPatientPage());
  }
}

class WaitingPatientsPage extends UI with WaitingPatientsBloc {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text('Waiting Patients'),
        prefixActions: [
          FHeaderAction.back(onPress: navigator.back),
        ],
        suffixActions: [
          FundsBadge(),
          CharityBadge(),
        ],
      ),
      content: isPatientsFlowEmpty
          ? Text('no patients are waiting').center()
          : FScaffold(
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
                  return FTappable(
                    onPress: () {
                      details(patient);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Satisfaction: ${patient.satisfaction.toStringAsFixed(1)}%',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.green),
                        ),
                        Row(
                          children: [
                            FButton.icon(
                              onPress: () {
                                admit(patient);
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
                },
              ),
            ),
    );
  }
}
