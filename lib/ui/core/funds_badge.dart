import 'package:flutter/material.dart';
import 'package:hospital/domain/api/settings_repository.dart';
import 'package:hospital/main.dart';

mixin FundsBloc {
  int get funds => settingsRepository.state.funds;
  int get charity => settingsRepository.state.charity;
}

class FundsBadge extends UI with FundsBloc {
  @override
  Widget build(BuildContext context) {
    return Badge(
      label: funds.text(),
    );
  }
}

class CharityBadge extends UI with FundsBloc {
  @override
  Widget build(BuildContext context) {
    return Badge(
      label: charity.text(),
    );
  }
}
