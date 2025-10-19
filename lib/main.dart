import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital/features/home/home.dart';
import 'package:hospital/navigator.dart';
import 'package:hospital/objectbox.g.dart';
import 'package:hospital/repositories/patient_repository.dart';
import 'package:hospital/repositories/staff_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

void main() async {
  final appInfo = await PackageInfo.fromPlatform();
  final path = await getApplicationDocumentsDirectory();
  final store = await openStore(
    directory: join(path.path, appInfo.appName),
  );

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PatientsRepository>(
          create: (context) => PatientsRepository(store),
        ),
        RepositoryProvider<StaffRepository>(
          create: (context) => StaffRepository(store),
        ),
      ],
      child: const HospitalApp(),
    ),
  );
}

class HospitalApp extends StatelessWidget {
  const HospitalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigator.navigatorKey,
      home: HomeView(),
    );
  }
}
