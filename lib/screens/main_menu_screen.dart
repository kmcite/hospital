import 'package:flutter/material.dart';
import 'package:hospital/business/hospital.dart';
import 'package:hospital/business/main_menu.dart';
import 'package:hospital/screens/game_screen.dart';
import 'package:hospital/features/main_menu_button.dart';
import 'package:hospital/utils/navigation.dart';
import 'package:hospital/screens/settings_screen.dart';
import 'package:hospital/utils/di.dart';
import 'package:hospital/utils/sm.dart';

class MainMenuScreen extends UI {
  final MainMenuProvider mainMenu;
  const MainMenuScreen({super.key, required this.mainMenu});

  @override
  Widget build(BuildContext context) {
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
              onPressed: mainMenu.onContinueGame()
                  ? () => mainMenu.continueGame()
                  : null,
            ),

            MainMenuButton(
              text: 'New Game',
              icon: Icons.add_circle_outline,
              onPressed: () {
                mainMenu.startNewGame();
                context.push(
                  GameScreen(
                    hospital: context.get(hospitalProvider),
                  ),
                );
              },
            ),

            MainMenuButton(
              text: 'Load Game',
              icon: Icons.folder_open,
              onPressed: mainMenu.onSavedGame()
                  ? () {
                      mainMenu.loadFromSavedGame();
                    }
                  : null,
            ),

            MainMenuButton(
              text: 'Settings',
              icon: Icons.settings,
              onPressed: () {
                context.push(
                  SettingsScreen(
                    hospital: context.get(hospitalProvider),
                  ),
                );
              },
            ),

            MainMenuButton(
              text: 'Exit',
              icon: Icons.exit_to_app,
              onPressed: () {
                mainMenu.exitGame();
              },
            ),
          ],
        ),
      ),
    );
  }
}
