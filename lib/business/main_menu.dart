import 'package:hospital/apis/game_repository.dart';
import 'package:hospital/utils/provider.dart';

final mainMenuProvider = inject(
  (ref) => MainMenuController(ref(gameRepositoryProvider)),
);

class MainMenuController(
  final GameRepository gameRepository,
) {
  void continueGame() {}

  void pauseGame() {}

  void loadFromSaved() {}
}
