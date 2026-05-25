import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital/api/repositories.dart';
import 'package:hospital/business/receptionists.dart';
import 'package:hospital/features/dark_mode.dart';
import 'package:hospital/business/doctor_cubit.dart';
import 'package:hospital/features/administration_office.dart';
import 'package:hospital/features/reception_counter.dart';
import 'package:hospital/features/doctor_room.dart';
import 'package:hospital/business/money_system.dart';
import 'package:hospital/business/patients_bloc.dart';
import 'package:hospital/business/nursing_system.dart';

import 'package:hospital/utils/navigation.dart';

bool isRunning = true;
int loopNumber = 1;
void main() async {
  /// REPOSITORIES
  final receptionistsRepository = ReceptionistsRepository();

  /// BLOCS
  final doctorBloc = DoctorBloc();
  final patientsBloc = PatientsBloc();
  final receptionistsBloc = ReceptionistsCubit(receptionistsRepository);
  final nursingBloc = NursingBloc();
  final moneyBloc = MoneyBloc();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: receptionistsRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: doctorBloc),
          BlocProvider.value(value: patientsBloc),
          BlocProvider.value(value: receptionistsBloc),
          BlocProvider.value(value: nursingBloc),
          BlocProvider.value(value: moneyBloc),
        ],
        child: const HospitalGame(),
      ),
    ),
  );
  while (isRunning) {
    log('------------------');
    log('loop # ${loopNumber++}');
    log('------------------');
    final patient = patientsBloc.create();
    final chit = receptionistsBloc.createChit(patient);
    if (chit != null) {
      final consultation = doctorBloc.prescribe(chit);
      nursingBloc.treat(consultation);
      final finalizedChit = moneyBloc.collectFees(chit);
      log('Treatment Happened $finalizedChit');
    }
    log('------------------');

    await Future.delayed(Duration(seconds: 2));
  }
  patientsBloc.close();
  nursingBloc.close();
}

class HospitalGame extends StatelessWidget {
  const HospitalGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: darkMode.value ? ThemeMode.dark : ThemeMode.light,
      home: PageView(
        children: [
          // Gatekeeper(),
          ReceptionCounter(),
          DoctorRoom(),
          AdministrationOffice(),
        ],
      ),
    );
  }
}
