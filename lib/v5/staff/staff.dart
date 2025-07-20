import 'package:flutter/material.dart';

class Staff {}

class StaffBloc extends ChangeNotifier {
  final List<Staff> staff = [];
  void hire(Staff staff) {
    notifyListeners();
  }

  void fire(Staff staff) {
    // staff.fire();
    notifyListeners();
  }
}
