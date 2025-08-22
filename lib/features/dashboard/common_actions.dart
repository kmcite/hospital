import 'package:hospital/features/patients/unsatisfied_patients.dart';
import 'package:hospital/features/staff/all_staff.dart';
import 'package:hospital/main.dart';
import 'package:hospital/utils/navigator.dart';
import 'package:hospital/features/balance/receipts.dart';
import 'package:hospital/features/patients/managed_patients.dart';
import 'package:hospital/features/reception/reception_station.dart';
import 'package:hospital/features/settings/settings.dart';
import 'package:hux/hux.dart';

import '../balance/money_investor.dart';
import '../patients/referred_patients.dart';

class CommonActions extends UI {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        FilledButton(
          onPressed: () => navigator.to(ReferredPatients()),
          child: Icon(FeatherIcons.filter),
        ),
        FilledButton(
          onPressed: () => navigator.to(ManagedPatients()),
          child: Icon(FeatherIcons.heart),
        ),
        FilledButton(
          onPressed: () => navigator.to(ReceiptsPage()),
          child: Icon(FeatherIcons.dollarSign),
        ),
        FilledButton(
          onPressed: () => navigator.to(ReceptionStation()),
          child: Icon(FeatherIcons.messageCircle),
        ),
        FilledButton(
          onPressed: () => navigator.to(SettingsPage()),
          child: Icon(FeatherIcons.settings),
        ),
        FilledButton(
          onPressed: () => navigator.to(AllStaffs()),
          child: Icon(FeatherIcons.scissors),
        ),
        MoneyInvestor(),
        FilledButton(
          onPressed: () => navigator.to(UnsatisfiedPatientsPage()),
          child: Icon(Icons.sentiment_dissatisfied),
        ),
      ],
    ).pad();
  }
}
