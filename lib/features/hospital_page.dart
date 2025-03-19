import 'package:forui/forui.dart';
import 'package:hospital/domain/models/patient.dart';
import 'package:hospital/domain/api/doctors.dart';
import 'package:hospital/features/hire_doctor_dialog.dart';
import 'package:hospital/domain/api/patients_repository.dart';
import 'package:hospital/features/facilities_page.dart';
import 'package:hospital/domain/api/hospital_funds.dart';
import 'package:hospital/features/admitted_patients_page.dart';
import 'package:hospital/features/waiting/waiting_patients_page.dart';
import 'package:hospital/main.dart';
import 'package:hospital/navigator.dart';

import '../domain/api/dark.dart';
import '../domain/models/doctor.dart';

mixin HospitalBloc {
  int get hospitalFunds => hospitalFundsRepository.hospitalFunds;
  int get charityFunds => hospitalFundsRepository.charityFunds;
  List<Doctor> get onDutyDoctors => doctorsRepository.doctorsOnDuty;
  List<Doctor> get doctorsAlreadyHired => doctorsRepository.doctorsHired;

  void hire(Doctor doctor) => doctorsRepository.hire(doctor);
  void fire(Doctor doctor) => doctorsRepository.fire(doctor);
  void leave(Doctor doctor) => doctorsRepository.leave(doctor);
  void callForDuty(Doctor doctor) => doctorsRepository.callForDuty(doctor);
  int get numberOfTotalPatients => patientsRepository.getAll().length;

  int get numberOfAdmittedPatients {
    return patientsRepository.getPatientsByStatus(Status.admitted).length;
  }

  int get numberOfWaitingPatients =>
      patientsRepository.numberOfWaitingPatients();

  bool dark([bool? _dark]) {
    if (_dark != null) {
      darkRM.toggle();
    }
    return darkRM.state;
  }
}

class HospitalPage extends UI with HospitalBloc {
  @override
  const HospitalPage({super.key});
  @override
  Widget build(BuildContext context) {
    final tileGroup = <Widget>[
      FTile(
        title: 'total patients'.text(),
        details: numberOfTotalPatients.text(),
        onPress: () => navigator.to(AdmittedPatientsPage()),
      ),
      FTile(
        title: 'admitted patients'.text(),
        details: numberOfAdmittedPatients.text(),
        onPress: () => navigator.to(AdmittedPatientsPage()),
      ),
      FTile(
        title: 'waiting patients'.text(),
        details: numberOfWaitingPatients.text(),
        onPress: () => navigator.to(WaitingPatientsPage()),
      ),
      // FTile(
      //   title: WaitingSlider(),
      //   suffixIcon: context
      //       .of<FlowRepository>()
      //       .flowState
      //       .countdownRemaining
      //       .text(textScaleFactor: 1.4),
      // ),
      FTile(
        onPress: () => navigator.to(FacilitiesPage()),
        title: Text('Facilities'),
      ),
    ];
    return FScaffold(
      header: FHeader(
        title: FIcon(FAssets.icons.hospital, size: 102),
        actions: [
          FHeaderAction(
            icon: FIcon(dark() ? FAssets.icons.moon : FAssets.icons.sun),
            onPress: () => dark(dark()),
          )
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          spacing: 16,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 12,
                    children: [
                      FBadge(
                        label: 'Funds: ${hospitalFunds}'.text(),
                      ),
                      FBadge(
                        label: 'Charity: ${charityFunds}'.text(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            FTileGroup.builder(
              count: tileGroup.length,
              divider: FTileDivider.full,
              tileBuilder: (context, index) => tileGroup.elementAt(index),
            ),
            FDivider(),
            'On Duty Doctors'.text(),
            FTileGroup.builder(
              count: onDutyDoctors.length,
              divider: FTileDivider.full,
              tileBuilder: (context, index) {
                final doctor = onDutyDoctors.elementAt(index);
                return FTile(
                  title: doctor.text(),
                  onPress: () => leave(doctor),
                );
              },
            ),
            'Hired Doctors'.text(),
            FTileGroup.builder(
              count: doctorsAlreadyHired.length,
              divider: FTileDivider.full,
              tileBuilder: (context, index) {
                final doctor = doctorsAlreadyHired.elementAt(index);
                return FTile(
                  title: doctor.text(),
                  suffixIcon: FButton.icon(
                    style: FButtonStyle.destructive,
                    child: 'FIRE'.text(),
                    onPress: () {
                      fire(doctor);
                    },
                  ),
                  onPress: () {
                    callForDuty(doctor);
                  },
                );
              },
            ),
            FButton(
              onPress: () async {
                final doctor = await navigator.toDialog<Doctor>(
                  HireDoctorDialog(),
                );
                if (doctor != null) hire(doctor);
              },
              label: 'HIRE DOCTOR'.text(),
            ),
          ],
        ).pad(),
      ),
    );
  }
}
