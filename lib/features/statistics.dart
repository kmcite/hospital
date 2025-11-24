import 'package:flutter/material.dart';
import 'package:hospital/domain/models/patient.dart';
import 'package:hospital/domain/models/staff.dart';
import 'package:hospital/utils/context.dart';
import 'package:hospital/utils/notifier.dart';
import 'package:hospital/utils/notifier_provider.dart';

class StatisticsNotifier extends Notifier {
  StatisticsNotifier(super.context);

  int _funds = 10000;
  int get funds => _funds;

  // Patient statistics
  int get totalPatients => context.of<Patients>().length;
  int get newPatientsToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return context
        .of<Patients>()
        .getAll()
        .where((patient) => patient.registrationDate.isAfter(today))
        .length;
  }

  // Staff statistics
  int get totalStaff => context.of<Staffs>().length;
  int get totalDoctors => context
      .of<Staffs>()
      .getAll()
      .where((staff) => staff.role.toLowerCase().contains('doctor'))
      .length;
  int get totalNurses => context
      .of<Staffs>()
      .getAll()
      .where((staff) => staff.role.toLowerCase().contains('nurse'))
      .length;

  void investInProjects() {
    _funds += 1000;
    notifyListeners();
  }

  void requestFunds() {
    _funds -= 500;
    notifyListeners();
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NotifierProvider<StatisticsNotifier>(
      create: StatisticsNotifier.new,
      builder: (context, notifier) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hospital Statistics",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Financial Stats Card
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Financial Status",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Available Funds: \$${notifier.funds}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => notifier.investInProjects(),
                            child: const Text("Invest in Projects (+\$1000)"),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () => notifier.requestFunds(),
                            child: const Text("Request Funds (-\$500)"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Patient Stats Card
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Patient Statistics",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Total Patients: ${notifier.totalPatients}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        "New Patients Today: ${notifier.newPatientsToday}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Staff Stats Card
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Staff Statistics",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Total Staff: ${notifier.totalStaff}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Doctors: ${notifier.totalDoctors}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Nurses: ${notifier.totalNurses}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
