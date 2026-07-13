import 'package:flutter/material.dart';
import 'package:hospital/apis/events.dart';
import 'package:hospital/business/main_menu.dart';
import 'package:hospital/features/main_menu_button.dart';
import 'package:hospital/screens/game_screen.dart';
import 'package:hospital/screens/load_game_dialog.dart';
import 'package:hospital/screens/settings_screen.dart';
import 'package:hospital/utils/messaging.dart';
import 'package:hospital/utils/provider.dart';
import 'package:navigation/navigation.dart';

class GameMenuScreen extends StatelessWidget {
  const GameMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mainMenu = context.of(mainMenuProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MainMenuButton(
              text: 'Continue Game',
              icon: Icons.play_arrow,
              onPressed: () {
                mainMenu.continueGame();
                context.push(GameScreen());
              },
            ),

            MainMenuButton(
              text: 'New Game',
              icon: Icons.add_circle_outline,
              onPressed: () {
                send(StartGame());
                context.push(GameScreen());
              },
            ),

            MainMenuButton(
              text: 'Load Game',
              icon: Icons.folder_open,
              onPressed: () {
                context.pushDialog(LoadGameDialog());
              },
            ),

            MainMenuButton(
              text: 'Settings',
              icon: Icons.settings,
              onPressed: () {
                context.push(
                  SettingsScreen(),
                );
              },
            ),

            MainMenuButton(
              text: 'Exit',
              icon: Icons.exit_to_app,
              onPressed: () {
                send(QuitGame());
              },
            ),
          ],
        ),
      ),
    );
  }
}
