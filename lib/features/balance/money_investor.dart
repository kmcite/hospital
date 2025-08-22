import 'package:hospital/features/balance/money_investment_dialog.dart';
import 'package:hospital/main.dart';
import 'package:hux/hux.dart';

class MoneyInvestor extends UI {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: openMoneyInvestmentDialog,
      child: Icon(FeatherIcons.monitor),
    );
  }
}
