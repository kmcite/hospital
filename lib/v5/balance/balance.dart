import 'package:flutter/material.dart';
import 'package:hospital/main.dart';
import 'package:hospital/utils/navigator.dart';
import 'package:hospital/v5/balance/investment.dart';
import 'package:hospital/v5/patients/patient.dart';
import 'package:hospital/v5/staff/staff.dart';

final balance = computed(
  () => _balance.fold(0.0, (next, prev) => next + prev),
);

final _balance = listSignal([150000.0]);

/// WILL WORK ON THIS
final balance_v3 = mapSignal<String, double>({'initial_balance': 150000.0});

void use_balance(double amount) {
  _balance.add(amount);
  // balance.set(balance() - amount);
}

void unuse_balance(double amount) {
  _balance.add(-amount);
  // balance.set(balance() + amount);
}

void clear_balancing_history() {
  final value = balance();
  _balance.clear();
  _balance.add(value);
}

class Balance extends UI {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 8,
          children: [
            FButton.icon(
              onPress: () {},
              child: 'PKR ${balance().toStringAsFixed(0)}'.text(
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Monaspace Krypton',
                ),
              ),
            ).pad(),
            Spacer(),
            FButton.icon(
              style: FButtonStyle.destructive(),
              onPress: () {},
              child: patients().length.text(
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
            ),
            FButton.icon(
              style: FButtonStyle.primary(),
              onPress: () => hireStaffDialog(context),
              child: Icon(FIcons.highlighter),
            ),
            FButton.icon(
              style: FButtonStyle.primary(),
              onPress: () => openMoneyInvestmentDialog(context),
              child: Icon(FIcons.inbox),
            ),
          ],
        ),
        Column(
          children: activeInvestments().map(
            (investment) {
              return Column(
                children: [
                  FTile(
                    title: Text('PKR ${investment.amount}'),
                    subtitle: Text('${investment.timeRemaining().inSeconds}s'),
                    prefix: CircularProgressIndicator(
                      value: 1 -
                          investment.timeRemaining().inSeconds /
                              investment.duration.inSeconds,
                    ),
                    suffix: Builder(
                      builder: (context) {
                        if (investment.isClaimed()) {
                          return Text(
                              'PKR${investment.totalReturn().toStringAsFixed(0)}');
                        } else if (investment.isMatured()) {
                          return Text(
                              'PKR ${investment.totalReturn().toStringAsFixed(0)}');
                        } else {
                          return IconButton(
                            onPressed: () => withdraw_early(investment.id),
                            icon: Text(
                                'PKR ${investment.earlyWithdrawalReturn().toStringAsFixed(0)}'),
                          );
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}

Future<void> hireStaffDialog(BuildContext context) {
  return navigator.toDialog(
    GUI(
      () => FDialog(
        body: Column(
          children: [
            for (final staff in staffs())
              FTile(
                title: staff.text(),
              ),
          ],
        ),
        actions: [
          FButton.icon(
            onPress: () {
              navigator.back();
            },
            child: Text('WILL WORK ON THIS'),
          ),
        ],
      ),
    ),
  );
}

Future<void> openMoneyInvestmentDialog(BuildContext context) {
  double amount = 0;
  final duration_ = signal<double>(0);
  return navigator.toDialog(
    Watch(
      (_) => FDialog(
        body: Column(
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
                      balance()
                  ? 'Your current balace is insufficient for this much investment'
                  : null,
              autovalidateMode: AutovalidateMode.always,
            ),
            FSlider(
              controller: FContinuousSliderController(
                selection: FSliderSelection(max: duration_()),
              ),
              onChange: (value) {
                duration_.set(value.offset.max);
              },
              label: Text('Time: ${(duration_() * 50).toInt()} seconds'),
            ),
          ],
        ),
        actions: [
          FButton(
            onPress: () {
              use_balance(amount);
              invest(
                amount: amount,
                duration: Duration(
                  seconds: (duration_() * 50).toInt(),
                ),
              );
              navigator.back();
            },
            child: Text('Invest'),
          ),
        ],
      ),
    ),
  );
}
