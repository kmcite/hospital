import 'package:flutter/material.dart';
import 'package:hospital/apis/events.dart';
import 'package:hospital/business/dark.dart';
import 'package:hospital/utils/messaging.dart';
import 'package:signals/signals.dart';

final class SettingsScreen extends SignalConsumer {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: .stretch,
          spacing: kSpacing,
          children: [
            ElevatedButton.icon(
              onPressed: () => send(DarkToggled()),
              icon: Icon(
                darkRead.darkSignal.choose(Icons.dark_mode, Icons.light_mode),
              ),
              label: Text(
                darkRead.darkSignal.choose('DARK', 'LIGHT'),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => send(ResetGame()),
              icon: const Icon(Icons.restart_alt),
              label: const Text('RESET GAME'),
            ),
          ],
        ),
      ),
    );
  }
}

