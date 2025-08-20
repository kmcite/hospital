import 'package:flutter/material.dart';
import 'package:hospital/main.dart';

class AnimatedProgressBar extends UI {
  const AnimatedProgressBar({super.key, required this.progress});
  final FlutterComputed<double> progress;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TweenAnimationBuilder(
          tween: Tween(begin: 1.0, end: progress()),
          duration: Duration(milliseconds: 1000),
          builder: (context, value, child) {
            return Slider(
              // minHeight: 16,
              value: value,
              // trackGap: totalTimeForNext() * 5 - value * totalTimeForNext() * 5,
              // divisions: totalTimeForNext(),
              onChanged: null,
              // borderRadius: BorderRadius.circular(16),
              // trackGap: 16,
            );
          },
        ),
      ],
    );
  }
}
