import 'dart:developer';
import 'package:hospital/main.dart';
import 'package:hospital/models/investment.dart';
import 'package:hospital/models/receipt.dart';
import 'package:hospital/repositories/balance_api.dart';
import 'package:hospital/repositories/investments_api.dart';

class MoneyInvestmentBloc extends Bloc {
  /// SOURCES
  late final BalanceRepository balanceRepository = watch();
  late final InvestmentsRepository investmentsRepository = watch();

  /// GLOBAL STATE
  double get balance => balanceRepository.balance;

  /// LOCAL STATE (fractional amount: 0–1)
  double _amount = 0.0;
  double _duration = 0.05; // fraction of 50s

  void setAmount(double value) {
    _amount = value.clamp(0.0, 1.0);
    notifyListeners();
  }

  void setDuration(double value) {
    _duration = value.clamp(0.0, 1.0);
    notifyListeners();
  }

  Duration get durationIn50Seconds {
    return Duration(seconds: (_duration * 50).toInt());
  }

  double get amountToInvest => _amount * balance;
  double get amountRemaining => balance - amountToInvest;

  /// MUTATIONS
  void invest() {
    print(-amountToInvest);
    final receipt = Receipt(balance: -amountToInvest);
    balanceRepository.put(receipt);
    investmentsRepository.activate(
      Investment(
        investedAmount: amountToInvest,
        duration: durationIn50Seconds,
        onCompleted: (investment) {
          investmentsRepository.archive(investment);
          final newReceipt = Receipt(
            balance: investment.currentAmount,
            metadata: {
              'investmentId': investment.id,
              'type': 'investment_completed',
            },
          );
          balanceRepository.put(newReceipt);
          log('✅ Investment completed: ${investment.id}');
        },
      ),
    );
    navigator.back();
  }

  String? validator(String? value) {
    final parsed = double.tryParse(value ?? '0') ?? 0;
    return parsed > balance
        ? 'Your current balance is insufficient for this investment'
        : null;
  }
}

class MoneyInvestmentDialog extends Feature<MoneyInvestmentBloc> {
  @override
  MoneyInvestmentBloc create() => MoneyInvestmentBloc();

  @override
  Widget build(context, controller) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Investment Money',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 8),
            Chip(
              label: Text(
                '${controller.amountToInvest.toInt()} / ${controller.amountRemaining.toInt()}',
              ),
            ),
            SizedBox(height: 8),
            Slider(
              label: controller._amount.toString(),
              value: controller._amount,
              secondaryTrackValue: controller._duration,
              onChanged: controller.setAmount,
            ),
            SizedBox(height: 8),
            Chip(
              label: Text(
                '${controller.durationIn50Seconds.inSeconds} seconds',
              ),
            ),
            SizedBox(height: 8),
            Slider(
              label: 'Duration',
              value: controller._duration,
              onChanged: controller.setDuration,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => controller.invest(),
                  child: Text('Invest'),
                ),
                SizedBox(width: 8),
                TextButton(
                  onPressed: () => navigator.back(),
                  child: Text('Cancel'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
