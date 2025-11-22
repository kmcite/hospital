import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class DifficultySlider extends StatelessWidget {
  const DifficultySlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Difficulty Slider'),
        FSlider(
          controller: FContinuousSliderController(
            selection: FSliderSelection(max: 0.6),
          ),
          // initialSelection: FSliderSelection(max: 0.6),
        ),
      ],
    );
  }
}
