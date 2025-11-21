import 'package:hospital/main.dart';

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
