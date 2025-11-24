import 'package:flutter/material.dart';

class VolumeSlider extends StatefulWidget {
  const VolumeSlider({super.key});

  @override
  State<VolumeSlider> createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  double _volume = 0.6;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.volume_up),
            const SizedBox(width: 8),
            const Text(
              'Volume',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Slider(
          value: _volume,
          onChanged: (value) {
            setState(() {
              _volume = value;
            });
          },
          min: 0.0,
          max: 1.0,
          divisions: 10,
          label: '${(_volume * 100).round()}%',
        ),
      ],
    );
  }
}
