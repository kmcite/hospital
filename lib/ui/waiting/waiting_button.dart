import 'package:flutter/material.dart';
import 'package:hospital/main.dart';

final _progressState = RM.inject(() => 0.0);

mixin WaitingBloc {
  double get progress => _progressState.state;

  void startProgress(double total) {
    for (var i = 0; i <= total; i++) {
      Future.delayed(Duration(milliseconds: (i * 17).round()), () {
        _progressState.state = i / total;
      });
    }
  }
}

class WaitingSlider extends UI with WaitingBloc {
  final double total;
  final double current;
  final Color? color;

  const WaitingSlider({
    super.key,
    this.total = 100,
    this.current = 0,
    this.color,
  });

  @override
  Widget build(context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LinearProgressIndicator(
          value: current / total,
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? theme.colorScheme.primary,
          ),
        ),
        if (current > 0) ...[
          const SizedBox(height: 4),
          Text(
            '${(current / total * 100).toStringAsFixed(1)}%',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ],
    );
  }
}
