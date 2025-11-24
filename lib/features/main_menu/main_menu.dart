import 'package:flutter/material.dart';
import 'package:hospital/domain/repositories/game_repository.dart';
import 'package:hospital/features/home.dart';
import 'package:hospital/features/main_menu/settings/settings.dart';
import 'package:hospital/utils/context.dart';
import 'package:hospital/utils/navigator.dart';
import 'package:hospital/utils/notifier.dart';
import 'package:hospital/utils/notifier_provider.dart';

class MainMenuNotifier extends Notifier {
  MainMenuNotifier(super.context);

  late Games games = context.of<Games>();

  List<GameModel> allGames = [
    GameModel(),
  ];

  GameModel? get firstGame => allGames.firstOrNull;

  bool get canContinue => firstGame != null;
  bool get canLoad => games.length > 1;

  void newGame() {
    navigator.to(HomeScreen());
  }

  void continueGame() {
    navigator.to(HomeScreen());
  }

  void loadGame() {
    navigator.to(HomeScreen());
  }
}

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NotifierProvider(
      create: MainMenuNotifier.new,
      builder: (context, menu) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.local_hospital,
                size: 100,
                color: Theme.of(context).colorScheme.primary,
              ),
              ElevatedButton.icon(
                onPressed: menu.newGame,
                icon: const Icon(Icons.add),
                label: const Text('New Game'),
              ),
              ElevatedButton.icon(
                onPressed: menu.canContinue ? menu.continueGame : null,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Continue'),
              ),
              ElevatedButton.icon(
                onPressed: menu.canLoad ? menu.loadGame : null,
                icon: const Icon(Icons.upload),
                label: const Text('Load'),
              ),
              ElevatedButton.icon(
                onPressed: () => navigator.to(const SettingsScreen()),
                icon: const Icon(Icons.settings),
                label: const Text('Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
