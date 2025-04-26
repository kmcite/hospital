import 'package:flutter/material.dart';
import 'package:hospital/main.dart';
import 'package:hospital/api/settings_repository.dart';

mixin FundsBloc {
  Modifier<int> get funds => settingsRepository.funds;
  Modifier<int> get charity => settingsRepository.charity;
}

class FundsBadge extends UI with FundsBloc {
  @override
  Widget build(context) {
    return Badge(
      label: Text(
        funds().toString(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class CharityBadge extends UI with FundsBloc {
  @override
  Widget build(context) {
    return Badge(
      label: Text(
        charity().toString(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
