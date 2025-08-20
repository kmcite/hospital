// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:hospital/main.dart';
import 'package:hospital/utils/navigator.dart';

Future<void> openMoneyInvestmentDialog() {
  double amount = 0;
  final duration_ = signal<double>(0);
  return navigator.toDialog(
    Watch(
      (_) => SimpleDialog(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            // FTextFormField(
            //   label: Text('Amount'),
            //   keyboardType: TextInputType.number,
            //   initialText: '',
            //   onChange: (value) {
            //     amount = double.tryParse(value) ?? 0;
            //   },
            //   validator: (value) => (double.tryParse(value ?? '0') ?? 0) >
            //           balanceRepository.balance()
            //       ? 'Your current balace is insufficient for this much investment'
            //       : null,
            //   autovalidateMode: AutovalidateMode.always,
            // ),
            // FSlider(
            //   controller: FContinuousSliderController(
            //     selection: FSliderSelection(max: duration_()),
            //   ),
            //   onChange: (value) {
            //     duration_.set(value.offset.max);
            //   },
            //   label: Text('Time: ${(duration_() * 50).toInt()} seconds'),
            // ),
          ],
        ),
        children: [
          // FButton(
          //   onPress: () {
          //     balanceRepository.useBalance(Receipt()..balance = amount);
          //     invest(
          //       amount: amount,
          //       duration: Duration(
          //         seconds: (duration_() * 50).toInt(),
          //       ),
          //     );
          //     navigator.back();
          //   },
          //   child: Text('Invest'),
          // ),
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
