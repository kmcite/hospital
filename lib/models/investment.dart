import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:hospital/main.dart';

/// Explicit lifecycle: Created → Active → Matured/Cancelled → Archived
class Investment extends ChangeNotifier implements ValueListenable<Investment> {
  final String id = faker.guid.guid();
  final double investedAmount;
  final Duration duration;

  bool isMatured = false;
  bool isCancelled = false;
  double currentAmount;
  Timer? _untilMatured;
  Duration remaining;

  /// Always non-null for predictability — default to noop.
  final void Function(Investment investment) onCompleted;

  Investment({
    required this.investedAmount,
    required this.duration,
    void Function(Investment investment)? onCompleted,
  })  : currentAmount = investedAmount,
        onCompleted = onCompleted ?? _noop,
        remaining = duration {
    _startTimer();
  }

  void _startTimer() async {
    if (duration <= Duration.zero) {
      log('⚠️ Skipping timer for zero/negative duration.');
      return;
    }

    _untilMatured = Timer.periodic(
      Durations.long2,
      (_) {
        final profitRate = faker.randomGenerator.decimal(
          min: 0.10, // Minimum 10% profit
          scale: 0.25, // Upto 35% profit
        );
        log('💰 Investment $id matured. Profit rate: ${(profitRate * 100).toStringAsFixed(2)}%');
        remaining -= Durations.long2;
        isMatured = true;
        currentAmount += investedAmount * profitRate;
        notifyListeners();
      },
    );
    await Future.delayed(duration);
    _untilMatured?.cancel();
    _untilMatured = null;
    onCompleted(this);
  }

  void cancel({bool refund = false}) {
    if (_untilMatured == null) return;

    _untilMatured?.cancel();
    _untilMatured = null;
    isCancelled = true;

    if (refund) {
      log('💸 Investment $id cancelled, refunding: $currentAmount');
    } else {
      log('💸 Investment $id cancelled, funds forfeited.');
      currentAmount = 0;
    }
  }

  static void _noop(Investment _) {}

  @override
  Investment get value => this;
}
