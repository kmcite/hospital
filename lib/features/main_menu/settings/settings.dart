import 'package:flutter/material.dart';
import 'package:hospital/utils/navigator.dart';

import 'difficulty_slider.dart';
import 'theme_mode.dart';
import 'volume_slider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: navigator.back,
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VolumeSlider(),
            SizedBox(height: 16),
            DifficultySlider(),
            SizedBox(height: 16),
            ThemeModeView(),
          ],
        ),
      ),
    );
  }
}
