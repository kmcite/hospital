import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hospital/v5/balance/balance.dart';
import 'package:signals/signals.dart';

class Investment {
  final String id;
  final double amount;
  final Duration duration;
  final double profitRate;
  final DateTime startTime;
  DateTime get endTime => startTime.add(duration);

  final Signal<bool> isClaimed = signal(false);
  final Signal<bool> isWithdrawnEarly = signal(false);
  final Signal<Duration> timeRemaining = signal(Duration.zero);
  late final Computed<bool> isMatured;
  final Computed<double> profit;
  final Computed<double> totalReturn;
  final Computed<double> earlyWithdrawalReturn;

  Timer? _updatesTimer;
  Timer? _maturityTimer;
  VoidCallback? onComplete;

  Investment({
    required this.id,
    required this.amount,
    required this.duration,
    this.profitRate = 0.10,
  })  : startTime = DateTime.now(),
        profit = computed(() => amount * profitRate),
        totalReturn = computed(() => amount * (1 + profitRate)),
        earlyWithdrawalReturn = computed(() => amount * 0.8) {
    _updatesTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        final rem = endTime.difference(DateTime.now());
        timeRemaining.set(rem.isNegative ? Duration.zero : rem);
      },
    );
    {
      isMatured = computed(
        () => DateTime.now().isAfter(
          startTime.add(duration),
        ),
      );
    }
  }

  void start(VoidCallback onCompleted) {
    onComplete = onCompleted;
    _maturityTimer = Timer(duration, () => onComplete?.call());
  }

  void cancel() {
    _maturityTimer?.cancel();
    _updatesTimer?.cancel();
  }
}

final activeInvestments = listSignal(<Investment>[]);
final historyInvestments = listSignal(<Investment>[]);

void invest({
  required double amount,
  required Duration duration,
}) {
  double calculateProfitRate(Duration duration) {
    final seconds = duration.inSeconds;
    if (seconds <= 1) return 0.01; // 1%
    if (seconds <= 3) return 0.03; // 3%
    if (seconds <= 7) return 0.07; // 7%
    if (seconds <= 15) return 0.10; // 10%
    if (seconds <= 30) return 0.15; // 15%
    return 0.20; // max 20%
  }

  final rate = calculateProfitRate(duration);

  final investment = Investment(
    id: UniqueKey().toString(),
    amount: amount,
    duration: duration,
    profitRate: rate,
  );

  investment.start(
    () {
      auto_claim(investment.id);
    },
  );

  activeInvestments.set(
    [...activeInvestments(), investment],
  );
}

void auto_claim(String id) {
  final investment = activeInvestments().firstWhere((i) => i.id == id);
  investment.isClaimed.set(true);
  activeInvestments.set([...activeInvestments()..remove(investment)]);
  historyInvestments.set([...historyInvestments(), investment]);
  unuse_balance(investment.totalReturn());
}

void withdraw_early(String id) {
  final investment = activeInvestments().firstWhere((i) => i.id == id);
  investment.cancel();
  investment.isWithdrawnEarly.set(true);
  activeInvestments.set([...activeInvestments()..remove(investment)]);
  historyInvestments.set([...historyInvestments(), investment]);
  unuse_balance(investment.earlyWithdrawalReturn());
}
