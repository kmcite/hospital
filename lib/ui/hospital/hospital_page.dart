import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/api/doctors.dart';
import 'package:hospital/api/patients_repository.dart';
import 'package:hospital/models/doctor.dart';
import 'package:hospital/navigator.dart';
import 'package:hospital/api/settings_repository.dart';
import 'package:hospital/ui/admitted/admitted_patients_page.dart';
import 'package:hospital/ui/hospital/total_patients_page.dart';
import 'package:hospital/ui/waiting/waiting_patients_page.dart';
import 'package:manager/dark/dark_repository.dart';
import '../../models/patient.dart';
import 'package:hospital/main.dart';
import '../symptoms/symptoms_page.dart';

mixin HospitalBloc {
  Modifier<int> get beds => settingsRepository.beds;
  Modifier<int> get funds => settingsRepository.funds;
  Modifier<int> get charity => settingsRepository.charity;
  Modifier<int> get waitingBeds => settingsRepository.waitingBeds;
  Modifier<bool> get dark => ([bool? value]) {
        if (value != null) {
          darkRepository.dark = value;
        }
        return darkRepository.dark;
      };

  int? get remainingTimeForNextPatient =>
      patientsRepository.remainingTimeForNextPatient;

  int get numberOfTotalPatients => patientsRepository.getAll().length;
  int get numberOfAdmittedPatients =>
      patientsRepository.getByStatus(Status.admitted).length;
  int get numberOfWaitingPatients => patientsRepository.getByStatus().length;

  CollectionModifier<Doctor> get doctors => doctorsRepository;
  Iterable<Doctor> get onDutyDoctors =>
      doctorsRepository.getDoctorsByStatus(DoctorStatus.onDuty);
  Iterable<Doctor> get onLeaveDoctors =>
      doctorsRepository.getDoctorsByStatus(DoctorStatus.onLeave);
  Iterable<Doctor> get hirable =>
      doctorsRepository.getDoctorsByStatus(DoctorStatus.availableForHire);
}

/// IMPORTANT STUFF
void _toggleDark() => darkRepository.toggle();
bool get _dark => darkRepository.dark;

class HospitalPage extends UI with HospitalBloc {
  @override
  List<Listenable> get listenables => super.listenables
    ..addAll(
      [
        doctorsRepository,
        patientsRepository,
      ],
    );
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: 'hospital'.text(),
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
              progressIndicatorTheme: ProgressIndicatorThemeData(
                // ignore: deprecated_member_use
                year2023: false,
              ),
            ),
            child: CircularProgressIndicator(
              value: patientsRepository.value,
            ),
          ),
          FButton.icon(
            child: FIcon(
              _dark ? FAssets.icons.moon : FAssets.icons.sun,
            ),
            onPress: _toggleDark,
          ),
          FButton.icon(
            onPress: () => navigator.to(SymptomsPage()),
            child: FIcon(FAssets.icons.syringe),
          )
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            'informations'.text(),
            Row(
              children: [
                FBadge(label: "beds: ${beds()}".text()).pad(all: 4),
                FBadge(label: "funds: ${funds()}".text()).pad(all: 4),
                FBadge(label: "charity: ${charity()}".text()).pad(all: 4),
              ],
            ),
            FDivider(),
            'counters'.text(),
            Column(
              children: [
                FButton(
                  label: FIcon(FAssets.icons.ambulance),
                  onPress: () => navigator.to(TotalPatientsPage()),
                ).pad(),
                FButton(
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FIcon(FAssets.icons.hospital),
                    ],
                  ),
                  onPress: () => navigator.to(AdmittedPatientsPage()),
                ).pad(),
                FButton(
                  label: FIcon(FAssets.icons.timerReset),
                  onPress: () => navigator.to(WaitingPatientsPage()),
                ).pad(), // const Divider(),
              ],
            ),
            FDivider(),
            FTileGroup(
              label: 'on duty doctors'.text(),
              children: List.generate(
                onDutyDoctors.length,
                (index) {
                  final doctor = onDutyDoctors.elementAt(index);
                  return FTile(
                    title: doctor.name.text(),
                    subtitle: doctor.status.text(),
                    onPress: () {
                      doctors(doctor..status = DoctorStatus.onLeave);
                    },
                  );
                },
              ),
            ),
            FDivider(),
            FTileGroup(
              label: 'on leave doctors'.text(),
              children: List.generate(
                onLeaveDoctors.length,
                (index) {
                  final doctor = onLeaveDoctors.elementAt(index);
                  return FTile(
                    title: doctor.name.text(),
                    subtitle: doctor.status.text(),
                    onPress: () {
                      doctors(doctor..status = DoctorStatus.onDuty);
                    },
                  );
                },
              ),
            ),
            FDivider(),
            FTileGroup(
              label: 'available doctors'.text(),
              children: List.generate(
                hirable.length,
                (index) {
                  final doctor = hirable.elementAt(index);
                  return FTile(
                    title: doctor.name.text(),
                    subtitle: doctor.status.text(),
                    onPress: () {
                      doctors(doctor..status = DoctorStatus.onDuty);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
