import 'package:flutter/material.dart';

final userRepository = User();

class User extends ChangeNotifier {
  String _name = '';
  String get name => _name;
  set name(String value) {
    _name = value;
    notifyListeners();
  }
}
