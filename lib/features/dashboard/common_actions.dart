import 'package:hospital/features/balance/money_investment_dialog.dart';
import 'package:hospital/features/patients/unsatisfied_patients.dart';
import 'package:hospital/features/staff/all_staff.dart';
import 'package:hospital/main.dart';
import 'package:hospital/features/balance/receipts.dart';
import 'package:hospital/features/patients/managed_patients.dart';
import 'package:hospital/features/reception/reception_station.dart';
import 'package:hospital/features/settings/settings.dart';
// import 'package:hux/hux.dart'; // Already imported through main.dart
import 'package:hospital/features/patients/referred_patients.dart';

class CommonActionsBloc extends Bloc {
  void openMoneyInvestmentDialog() {
    navigator.toDialog(MoneyInvestmentDialog());
  }
}

class CommonActions extends Feature<CommonActionsBloc> {
  @override
  Widget build(BuildContext context, controller) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          IconButton(
            onPressed: () => navigator.to(ReferredPatients()),
            icon: Icon(Icons.filter_alt),
          ),
          IconButton(
            onPressed: () => navigator.to(ManagedPatients()),
            icon: Icon(Icons.favorite),
          ),
          IconButton(
            onPressed: () => navigator.to(ReceiptsPage()),
            icon: Icon(Icons.receipt),
          ),
          IconButton(
            onPressed: () => navigator.to(ReceptionStation()),
            icon: Icon(Icons.message),
          ),
          IconButton(
            onPressed: () => navigator.to(SettingsPage()),
            icon: Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () => navigator.to(AllStaffs()),
            icon: Icon(Icons.group),
          ),
          IconButton(
            onPressed: () => controller.openMoneyInvestmentDialog(),
            icon: Icon(Icons.monetization_on),
          ),
          IconButton(
            onPressed: () => navigator.to(UnsatisfiedPatientsPage()),
            icon: Icon(Icons.sentiment_dissatisfied),
          ),
        ],
      ),
    );
  }

  @override
  create() => CommonActionsBloc();
}
