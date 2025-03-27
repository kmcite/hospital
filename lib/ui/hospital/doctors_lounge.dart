import 'package:flutter/material.dart';
import 'package:hospital/domain/api/doctors.dart';
import 'package:hospital/domain/models/doctor.dart';
import 'package:hospital/main.dart';
import 'package:hospital/navigator.dart';
import 'package:hospital/ui/hospital/duty_assignment_dialog.dart';
import 'package:hospital/ui/hospital/hire_doctor_dialog.dart';

mixin DoctorsLoungeBloc {
  void hire() async {
    // final isHiringCapacityReached = settingsRepository().doctorsCapacity ==
    //     doctorsRepository.getAll().length;
    // if (isHiringCapacityReached) return;
    final toHire = await navigator.toDialog(HireDoctorDialog());
    if (toHire != null) {
      doctorsRepository.put(toHire);
    }
  }

  void toggleStatus(Doctor doctor) {
    doctorsRepository.put(
      doctor
        ..status = switch (doctor.status) {
          DoctorStatus.onLeave => DoctorStatus.onDuty,
          DoctorStatus.onDuty => DoctorStatus.hired,
          DoctorStatus.hired => DoctorStatus.availableForHire,
          DoctorStatus.availableForHire => DoctorStatus.onLeave,
        },
    );
  }
}

class DoctorsLounge extends UI with DoctorsLoungeBloc {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        'doctors lounge'.text(),
        'on leave doctors'.text(),
        Wrap(
          children: [
            ...doctorsRepository.getDoctorsByStatus(DoctorStatus.onLeave).map(
              (doctor) {
                return ActionChip(
                  tooltip: doctor.status.name,
                  label: doctor.name.text(),
                  onPressed: () => toggleStatus(doctor),
                ).pad();
              },
            ),
          ],
        ),
        'on duty doctors'.text(),
        Wrap(
          children: [
            ...doctorsRepository.getDoctorsByStatus(DoctorStatus.onDuty).map(
              (doctor) {
                return ActionChip(
                  tooltip: doctor.status.name,
                  label: doctor.name.text(),
                  onPressed: () => toggleStatus(doctor),
                ).pad();
              },
            ),
          ],
        ),
        'available doctors'.text(),
        Wrap(
          children: [
            ...doctorsRepository
                .getDoctorsByStatus(DoctorStatus.availableForHire)
                .map(
              (doctor) {
                return ActionChip(
                  tooltip: doctor.status.name,
                  label: doctor.name.text(),
                  onPressed: () => toggleStatus(doctor),
                ).pad();
              },
            ),
          ],
        ),
        'hired doctors'.text(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...doctorsRepository.getDoctorsByStatus().map(
                (doctor) {
                  return ActionChip(
                    tooltip: doctor.status.name,
                    label: doctor.name.text(),
                    onPressed: () => toggleStatus(doctor),
                  ).pad();
                },
              ),
            ],
          ),
        ),
        'actions'.text(),
        ListTile(
          onTap: hire,
          title: 'Hire'.text(),
          subtitle: 'hire more doctors'.text(),
        ),
        ListTile(
          onTap: assign,
          title: 'Assign to Duty'.text(),
          subtitle: 'select a doctor to duty'.text(),
        ),
      ],
    );
  }

  void assign() {
    navigator.toDialog(DutyAssignmentDialog());
  }
}
