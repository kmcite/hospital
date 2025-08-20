import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hospital/main.dart';

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
        final remaining = endTime.difference(DateTime.now());
        timeRemaining.set(remaining.isNegative ? Duration.zero : remaining);
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
