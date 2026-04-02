import 'package:hospital/pages/game_page.dart';
import 'package:hospital/pages/menu_page.dart';
import 'package:hospital/signals/navigation.dart';
import 'package:signals/signals_core.dart';

enum GameState { running, paused }

final gameStateSignal = signal(GameState.paused);

/// will be triggered at startup
final gameStateEffect = Effect(() {
  switch (gameStateSignal()) {
    case GameState.running:
      navigateUntill(GamePage());
      break;
    case GameState.paused:
      navigateUntill(MenuPage());
      break;
  }
});
