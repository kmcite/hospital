// ignore_for_file: unused_local_variable

import 'package:forui/forui.dart';
import 'package:hospital/main.dart';
import 'package:hospital/models/receipt.dart';
import 'package:hospital/repositories/balance_api.dart';
import 'package:hospital/repositories/investments_api.dart';
import 'package:hospital/utils/navigator.dart';

Future<void> openMoneyInvestmentDialog() {
  double amount = 0;
  final duration = signal<double>(0);
  return navigator.toDialog(
    Watch(
      (_) => FDialog(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            FTextFormField(
              label: Text('Amount'),
              keyboardType: TextInputType.number,
              initialText: '',
              onChange: (value) {
                amount = double.tryParse(value) ?? 0;
              },
              validator: (value) => (double.tryParse(value ?? '0') ?? 0) >
                      balanceRepository.balance()
                  ? 'Your current balace is insufficient for this much investment'
                  : null,
              autovalidateMode: AutovalidateMode.always,
            ),
            FSlider(
              controller: FContinuousSliderController(
                selection: FSliderSelection(max: duration()),
              ),
              onChange: (value) {
                duration.set(value.offset.max);
              },
              label: Text('Time: ${(duration() * 50).toInt()} seconds'),
            ),
          ],
        ),
        actions: [
          FButton(
            onPress: () {
              final receipt = Receipt(balance: amount);
              balanceRepository.useBalance(receipt);
              invest(
                amount: amount,
                duration: Duration(
                  /// why do we multiply by 50?
                  seconds: (duration() * 50).toInt(),
                ),
              ).then((_) => navigator.back());
            },
            child: Text('Invest'),
          )
        ],
      ),
    ),
  );
}

// /// Revert a receipt (negate amount)
// void useBalance(Receipt r) {
//   final balance = r.balance;
//   final updated = r..balance = -balance;
//   receipts[updated.id] = updated;
// }
