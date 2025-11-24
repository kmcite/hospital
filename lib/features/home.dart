import 'package:flutter/material.dart';
import 'package:hospital/domain/models/medical_record.dart';
import 'package:hospital/domain/models/patient.dart';
import 'package:hospital/domain/repositories/settings_repository.dart';
import 'package:hospital/features/departments/departments_screen.dart';
import 'package:hospital/features/statistics.dart';
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
  VoidCallback? _unsubscribe;

  HomeNotifier(super.context) {
    settingsRepository = context.of<SettingsRepository>();
    settingsRepository.addListener(() async {
      await pageController.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    });
  }

  late SettingsRepository settingsRepository;

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

  @override
  void dispose() {
    settingsRepository.removeListener(notifyListeners);
    super.dispose();
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
          child: Scaffold(
            body: PageView(
              controller: home.pageController,
              onPageChanged: home.onIndexChanged,
              children: const [
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
