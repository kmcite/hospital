import 'package:flutter/material.dart';
import 'package:hospital/business/load_game_provider.dart';
import 'package:hospital/utils/provider.dart';
import 'package:navigation/navigation.dart';
import 'package:signals/signals.dart';

class LoadGameDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loadGame = context.of(loadGameProvider);
    final availableGames = loadGame.availableGames();
    return AlertDialog(
      title: const Text('Load Game'),
      content: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        spacing: kSpacing,
        children: [
          for (final game in availableGames)
            ElevatedButton(
              onPressed: loadGame.selectedGame.value == game
                  ? null
                  : () => loadGame.onSelectedGameChanged(game),
              child: Text(
                '$game',
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: loadGame.canLoadGame.value ? () => context.pop() : null,
          child: const Text('Load'),
        ),
      ],
    );
  }
}
