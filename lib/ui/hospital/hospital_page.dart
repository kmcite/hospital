import 'package:flutter/material.dart';
import 'package:hospital/domain/api/doctors.dart';
import 'package:hospital/domain/api/settings_repository.dart';
import 'package:hospital/navigator.dart';
import 'package:hospital/ui/hospital/banner.dart';
import 'package:hospital/ui/hospital/hospital_counters.dart';
import 'package:hospital/ui/hospital/doctors_lounge.dart';
import 'package:hospital/main.dart';
import 'package:hospital/ui/symptoms.dart';

import '../../domain/models/doctor.dart';

mixin HospitalBloc {
  int get hospitalFunds => settingsRepository().funds;
  int get charityFunds => settingsRepository().charity;
  Iterable<Doctor> get onDutyDoctors => doctorsRepository.doctorsOnDuty;
  Iterable<Doctor> get doctorsAlreadyHired => doctorsRepository.doctorsHired;

  // void hire(Doctor doctor) {
  // final price = doctor.price;
  // settingsRepository.funds(price);
  // doctorsRepository.hire(doctor);
  // }

  // void fire(Doctor doctor) => doctorsRepository.fire(doctor);
  // void leave(Doctor doctor) => doctorsRepository.leave(doctor);
  // void callForDuty(Doctor doctor) => doctorsRepository.callForDuty(doctor);
}

class HospitalPage extends UI with HospitalBloc {
  @override
  const HospitalPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HospitalBanner(),
      body: Stack(
        children: [
          Opacity(
            child: Icon(
              Icons.local_hospital,
              size: 180,
            ),
            opacity: .5,
          ).center(),
          Opacity(
            opacity: 1,
            child: ListView(
              children: [
                HospitalCounters(),
                Divider(),
                DoctorsLounge(),
              ],
            ).pad(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigator.to(SymptomsPage()),
      ),
    );
  }
}
