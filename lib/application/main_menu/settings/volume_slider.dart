import 'package:hospital/main.dart';

class VolumeSlider extends StatelessWidget {
  const VolumeSlider({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Volume Slider'),
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
