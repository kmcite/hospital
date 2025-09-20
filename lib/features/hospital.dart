import 'dart:async';
import 'package:hospital/main.dart';
import 'package:hospital/features/dashboard/dashboard.dart';
import 'package:hospital/utils/theme.dart';
import 'package:hospital/models/receipt.dart';
import 'package:hospital/models/reception.dart';
import 'package:hospital/models/patient.dart';
import 'package:hospital/models/staff/doctor.dart';
import 'package:hospital/models/staff/nurse.dart';
import 'package:hospital/models/staff/receptionist.dart';
import 'package:hospital/repositories/patients_api.dart';

import '../repositories/balance_api.dart';
import '../repositories/receptions_api.dart';
import '../repositories/settings_api.dart';
import '../repositories/staff_api.dart';

class HospitalBloc extends Bloc {
  late final SettingsRepository settingsRepository = watch();
  late final BalanceRepository balanceRepository = watch();
  late final ReceptionsRepository receptionsRepository = watch();
  late final StaffRepository staffRepository = watch();
  late final PatientsRepository patientsRepository = watch();

  bool get dark => settingsRepository.dark;
  double get patientFees => settingsRepository.patientFees;
  double get patientReferalFees => settingsRepository.patientReferalFees;
  double get ambulanceFees => settingsRepository.ambulanceFees;

  Nurse? get currentNurse => staffRepository.currentNurse;
  Doctor? get currentDoctor => staffRepository.currentDoctor;
  Receptionist? get currentReceptionist => staffRepository.currentReceptionist;

  Iterable<Doctor> get doctors => staffRepository.doctors;
  Iterable<Nurse> get nurses => staffRepository.nurses;
  Iterable<Receptionist> get receptionists => staffRepository.receptionists;

  Iterable<Reception> get receptions => receptionsRepository.getAll();

  @override
  initState() {
    startPatientGeneration();
    startBackgroundProcesses();
  }

  void startPatientGeneration() {
    Timer.periodic(Duration(seconds: 30), (timer) {
      patientsRepository.generateRandomPatient();
    });
  }

  void startBackgroundProcesses() {
    Timer.periodic(Duration(seconds: 60), (timer) {
      processSalaries();
    });
  }

  void processSalaries() {
    for (final staff in staffRepository.getHiredStaff()) {
      balanceRepository.put(
        Receipt(
          balance: -staff.salary,
          metadata: {
            'type': 'Salary',
            'staffId': staff.id.toString(),
          },
        ),
      );
    }
  }

  void assignDoctor(Doctor doctor) {
    staffRepository.setCurrentDoctor(doctor);
  }

  void assignNurse(Nurse nurse) {
    staffRepository.setCurrentNurse(nurse);
  }

  void assignReceptionist(Receptionist receptionist) {
    staffRepository.setCurrentReceptionist(receptionist);
  }

  void processPatient(Patient patient) {
    if (currentReceptionist != null) {
      final reception = Reception.create(
        patient: patient,
        receptionist: currentReceptionist!,
      );
      receptionsRepository.put(reception);

      balanceRepository.put(
        Receipt(
          balance: reception.totalFees,
          metadata: {
            'type': 'Reception Fees',
            'patientId': patient.id.toString(),
            'mr': reception.mr.toString(),
          },
        ),
      );
    }
  }
}

class HospitalView extends Feature<HospitalBloc> {
  @override
  HospitalBloc create() => HospitalBloc();

  const HospitalView({super.key});

  @override
  Widget build(context, controller) {
    return MaterialApp(
      navigatorKey: navigator.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: HospitalTheme.lightTheme,
      darkTheme: HospitalTheme.darkTheme,
      builder: (context, child) => child!,
      themeMode: controller.dark ? ThemeMode.dark : ThemeMode.light,
      home: Dashboard(),
    );
  }
}
