import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/domain/repositories/doctors.dart';
import 'package:hospital/domain/repositories/patients_repository.dart';
import 'package:hospital/domain/models/doctor.dart';
import 'package:hospital/navigator.dart';
import 'package:hospital/domain/repositories/settings_repository.dart';
import 'package:hospital/ui/hospital/indicator.dart';
import 'package:manager/dark/dark_repository.dart';
import '../../domain/models/patient.dart';
import 'package:hospital/main.dart';
import '../symptoms/symptoms_page.dart';

final beds = settingsRepository.beds;
final funds = settingsRepository.funds;
final charity = settingsRepository.charity;
final waitingBeds = settingsRepository.waitingBeds;
final dark = ([bool? value]) {
  if (value != null) {
    darkRepository.state = value;
  }
  return darkRepository.state;
};

int? get remainingTimeForNextPatient =>
    patientsRepository.remainingTimeForNextPatient;

int get numberOfTotalPatients => patientsRepository.getAll().length;
int get numberOfAdmittedPatients =>
    patientsRepository.getByStatus(Status.admitted).length;
int get numberOfWaitingPatients => patientsRepository.getByStatus().length;

final doctors = doctorsRepository;
Iterable<Doctor> get onDutyDoctors =>
    doctorsRepository.getDoctorsByStatus(DoctorStatus.onDuty);
Iterable<Doctor> get onLeaveDoctors =>
    doctorsRepository.getDoctorsByStatus(DoctorStatus.onLeave);
Iterable<Doctor> get hirable =>
    doctorsRepository.getDoctorsByStatus(DoctorStatus.availableForHire);

/// IMPORTANT STUFF
void _toggleDark() => darkRepository.toggle();
bool get _dark => darkRepository.state;

class HospitalPage extends UI {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: 'hospital'.text(),
        suffixes: [
          Indicator(),
          FButton.icon(
            child: Icon(
              _dark ? FIcons.moon : FIcons.sun,
            ),
            onPress: _toggleDark,
          ),
          FButton.icon(
            onPress: () => navigator.to(SymptomsPage()),
            child: Icon(FIcons.syringe),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FAlert(
            title: 'informations'.text(),
            subtitle: Wrap(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FBadge(child: "beds: ${beds()}".text()).pad(all: 4),
                FBadge(child: "funds: ${funds()}".text()).pad(all: 4),
                FBadge(child: "charity: ${charity()}".text()).pad(all: 4),
              ],
            ),
          ),
          FAlert(
            title: 'unattended patients'.text(),
            subtitle: Wrap(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FBadge(
                  child: "24 ${waitingPatients.length}".text(),
                ).pad(all: 4),
              ],
            ),
          ),
          // Expanded(
          //   child: GridView(
          //     gridDelegate:
          //         SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          //     children: [
          //       FButton(
          //         child: Icon(
          //           FIcons.ambulance,
          //           size: 48,
          //         ),
          //         onPress: () => navigator.to(TotalPatientsPage()),
          //       ).pad(),
          //       FButton(
          //         child: Icon(
          //           FIcons.hospital,
          //           size: 48,
          //         ),
          //         onPress: () => navigator.to(AdmittedPatientsPage()),
          //       ).pad(),
          //       FButton(
          //         child: Icon(
          //           FIcons.timerReset,
          //           size: 48,
          //         ),
          //         onPress: () => navigator.to(WaitingPatientsPage()),
          //       ).pad(), // const Divider(),
          //     ],
          //   ),
          // ),
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
                  suffixIcon: CircularProgressIndicator(),
                );
              },
            ),
          ),
          // FDivider(),
          // FTileGroup(
          //   label: 'on leave doctors'.text(),
          //   children: List.generate(
          //     onLeaveDoctors.length,
          //     (index) {
          //       final doctor = onLeaveDoctors.elementAt(index);
          //       return FTile(
          //         title: doctor.name.text(),
          //         subtitle: doctor.status.text(),
          //         onPress: () {
          //           doctors(doctor..status = DoctorStatus.onDuty);
          //         },
          //       );
          //     },
          //   ),
          // ),
          // FDivider(),
          // FTileGroup(
          //   label: 'available doctors'.text(),
          //   children: List.generate(
          //     hirable.length,
          //     (index) {
          //       final doctor = hirable.elementAt(index);
          //       return FTile(
          //         title: doctor.name.text(),
          //         subtitle: doctor.status.text(),
          //         onPress: () {
          //           doctors(doctor..status = DoctorStatus.onDuty);
          //         },
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
