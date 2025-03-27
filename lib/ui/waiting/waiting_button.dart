import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/main.dart';

mixin WaitingBloc {
  // get flow => FlowRepository();
}

class WaitingSlider extends UI with WaitingBloc {
  const WaitingSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(
        begin: 0.0,
        // end: flow.flowState.countdownRemaining / flow.flowState.countdownTotal,
      ),
      builder: (context, value, child) => FProgress(value: value),
      duration: 17.milliseconds,
    );
  }
}
