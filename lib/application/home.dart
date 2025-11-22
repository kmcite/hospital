import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/application/departments/departments_screen.dart';
import 'package:hospital/application/statistics.dart';
import 'package:hospital/domain/models/medical_record.dart';
import 'package:hospital/domain/models/patient.dart';
import 'package:hospital/domain/repositories/settings_repository.dart';
import 'package:hospital/utils/context.dart';
import 'package:hospital/utils/notifier.dart';
import 'package:hospital/utils/notifier_provider.dart';

class PatientWithRecords {
  final PatientModel patient;
  final List<MedicalRecordModel> records;
  const PatientWithRecords({
    required this.patient,
    required this.records,
  });
}

class HomeNotifier extends Notifier {
  HomeNotifier(super.context) {
    settingsRepository.subscribe(() async {
      await pageController.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    });
  }

  late SettingsRepository settingsRepository = context.of();

  ///
  final PageController pageController = PageController();
  ////
  int get pageIndex => settingsRepository.settings.pageIndex;
  void onIndexChanged(
    int index, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    pageController.animateToPage(
      index,
      duration: duration,
      curve: curve,
    );
    settingsRepository.onPageChanged(index);
    notifyListeners();
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NotifierProvider<HomeNotifier>(
      create: HomeNotifier.new,
      builder: (context, home) {
        return SafeArea(
          child: FScaffold(
            child: PageView(
              controller: home.pageController,
              onPageChanged: home.onIndexChanged,
              children: [
                StatisticsScreen(),
                DepartmentsScreen(),
              ],
            ),
          ),
        );
      },
    );
  }
}
