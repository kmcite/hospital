import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/application/departments/staff_room/staff_room.dart';
import 'package:hospital/utils/notifier_provider.dart';

import 'pharmacy/pharmacy_room.dart';
import 'doctor_room/doctor_room.dart';
import 'minor_ot.dart';
import 'reception/reception.dart';
import 'ward/ward.dart';

mixin TabName {
  String get name;
}

class GameTabsNotifier extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class DepartmentsScreen extends StatelessWidget {
  const DepartmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NotifierProvider(
      create: (context) => GameTabsNotifier(),
      builder: (context, notifier) {
        final tabs = [
          MinorOT(),
          StaffRoom(),
          Reception(),
          DoctorRoom(),
          Ward(),
          PharmacyRoom(),
        ];
        return Column(
          children: [
            FBottomNavigationBar(
              index: notifier.currentIndex,
              onChange: (value) {
                notifier.setCurrentIndex(value);
              },
              children: [
                for (var tab in tabs)
                  FBottomNavigationBarItem(
                    label: Text(tab.name),
                    icon: Text(
                      tab.name.substring(0, 1),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),

            IndexedStack(
              index: notifier.currentIndex,
              children: tabs,
            ),
          ],
        );
      },
    );
  }
}
