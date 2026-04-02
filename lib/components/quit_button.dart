import 'package:flutter/material.dart';
import 'package:hospital/signals/game_state.dart';
import 'package:hospital/signals/navigation.dart';

class QuitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final shouldPop = await navigateToDialog<bool>(QuitDialog());

        if (shouldPop == true && context.mounted) {
          navigateBack();
          gameStateSignal.set(.paused);
        }
      },
      icon: Icon(Icons.close),
    );
  }
}

class ShouldQuit extends StatelessWidget {
  final Widget child;
  const ShouldQuit({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final shouldPop = await navigateToDialog<bool>(QuitDialog());

        if (shouldPop == true && context.mounted) {
          navigateBack();
        }
      },
      child: child,
    );
  }
}

class QuitDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Quit Game?'),
      content: const Text('Are you sure you want to quit the game?'),
      actions: [
        TextButton(
          onPressed: () => navigateBack(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => navigateBack(true),
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
