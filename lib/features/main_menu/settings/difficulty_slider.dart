import 'package:flutter/material.dart';

class DifficultySlider extends StatefulWidget {
  const DifficultySlider({super.key});

  @override
  State<DifficultySlider> createState() => _DifficultySliderState();
}

class _DifficultySliderState extends State<DifficultySlider> {
  double _difficulty = 0.6;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.speed),
            const SizedBox(width: 8),
            const Text(
              'Difficulty',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Slider(
          value: _difficulty,
          onChanged: (value) {
            setState(() {
              _difficulty = value;
            });
          },
          min: 0.0,
          max: 1.0,
          divisions: 10,
          label: '${(_difficulty * 100).round()}%',
        ),
      ],
    );
  }
}
