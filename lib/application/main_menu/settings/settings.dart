import 'package:hospital/main.dart';

import 'difficulty_slider.dart';
import 'theme_mode.dart';
import 'volume_slider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text('Settings'),
        suffixes: [
          FHeaderAction.x(onPress: navigator.back),
        ],
      ),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          VolumeSlider(),
          DifficultySlider(),
          ThemeModeView(),
        ],
      ),
    );
  }
}
