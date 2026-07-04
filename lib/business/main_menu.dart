import 'package:flutter/services.dart';
import 'package:hospital/domain/clock_repository.dart';
import 'package:hospital/utils/di.dart';
import 'package:hospital/utils/sm.dart';

class MainMenuState {
  final bool isRunning;
  final bool hasPausedGame;

  MainMenuState({
    this.isRunning = false,
    this.hasPausedGame = false,
  });

  MainMenuState copyWith({
    bool? isRunning,
    bool? hasPausedGame,
  }) {
    return MainMenuState(
      isRunning: isRunning ?? this.isRunning,
      hasPausedGame: hasPausedGame ?? this.hasPausedGame,
    );
  }
}

final mainMenuProvider = provider(
  (ref) => MainMenuProvider(ref(gameRepository)),
);

class MainMenuProvider extends Spark<MainMenuState> {
  final GameRepository gameRepository;
  MainMenuProvider(
    this.gameRepository,
  );
  late final onContinueGame = computed(
    () => gameRepository.continueGameSignal(),
  );
  late final onSavedGame = computed(
    () => gameRepository.savegameSignal(),
  );

  @override
  MainMenuState get initialState => MainMenuState();

  void exitGame() async {
    state = state.copyWith(isRunning: false, hasPausedGame: false);
    await SystemNavigator.pop(animated: true);
  }

  void startNewGame() {
    state = state.copyWith(isRunning: true, hasPausedGame: false);
    gameRepository.startGame();
  }

  void continueGame() {
    state = state.copyWith(isRunning: true, hasPausedGame: false);
  }

  void pauseGame() {
    state = state.copyWith(isRunning: false, hasPausedGame: true);
  }

  void loadFromSavedGame() {
    state = state.copyWith(isRunning: true, hasPausedGame: false);
  }
}
