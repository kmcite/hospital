import 'package:hospital/application/home.dart';
import 'package:hospital/application/main_menu/settings/settings.dart';
import 'package:hospital/domain/repositories/game_repository.dart';
import 'package:hospital/main.dart';

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
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Icon(FIcons.hospital, size: 150),
              Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FButton(
                    onPress: menu.newGame,
                    child: Text('New Game'),
                  ),
                  FButton(
                    onPress: menu.canContinue ? menu.continueGame : null,
                    child: Text('Continue'),
                  ),
                  FButton(
                    onPress: menu.canLoad ? menu.loadGame : null,
                    child: Text('Load'),
                  ),
                  FButton(
                    onPress: () {
                      navigator.to(SettingsScreen());
                    },
                    child: Text('Settings'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
