import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/api/doctors.dart';
import 'package:hospital/api/faker.dart';
import 'package:hospital/main.dart';
import 'package:hospital/models/doctor.dart';

/// DoctorsLounge Bloc
mixin DoctorsLoungeBloc {
  final getByStatus = doctorsRepository.getDoctorsByStatus;
  Iterable<Doctor> get onDutyDoctors => getByStatus();
  Iterable<Doctor> get onLeaveDoctors => getByStatus(DoctorStatus.onLeave);
  Iterable<Doctor> get hirable => getByStatus(DoctorStatus.availableForHire);
  changeStatus(Doctor doc) {
    if (doc.status == DoctorStatus.onLeave) {
      doc.status = DoctorStatus.onDuty;
    } else if (doc.status == DoctorStatus.onDuty) {
      doc.status = DoctorStatus.onLeave;
    } else if (doc.status == DoctorStatus.availableForHire) {
      doc.status = DoctorStatus.onDuty;
    }
    doctorsRepository.put(doc);
  }
}

class DoctorsLounge extends UI with DoctorsLoungeBloc {
  DoctorsLounge({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "DOCTORS LOUNGE",
        ),
        const SizedBox(height: 16),

        // Grid Layout (2x2)
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: _buildQuadrant(
                        "On Duty",
                        onDutyDoctors,
                        context,
                      ),
                    ),
                    Expanded(
                      child: _buildQuadrant(
                        "On Leave",
                        onLeaveDoctors,
                        context,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: _buildQuadrant(
                        "Available for Hire",
                        hirable,
                        context,
                      ),
                    ),
                    FButton.icon(
                      onPress: () {
                        doctorsRepository.put(
                          Doctor()
                            ..name = personFaker.name()
                            ..status = DoctorStatus.availableForHire,
                        );
                      },
                      child: FIcon(FAssets.icons.plus),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Helper method to build each quadrant
  Widget _buildQuadrant(
      String title, Iterable<Doctor> doctors, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.2),
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title.text(),
          const SizedBox(height: 8),
          Expanded(
            child: doctors.isNotEmpty
                ? ListView.separated(
                    itemCount: doctors.length,
                    separatorBuilder: (_, __) => Divider(
                      height: 1,
                      color: Theme.of(context).dividerColor,
                    ),
                    itemBuilder: (_, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: FTile(
                        title: Text(
                          doctors.elementAt(index).name,
                        ),
                        onPress: () {
                          changeStatus(doctors.elementAt(index));
                        },
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      "No doctors available",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
