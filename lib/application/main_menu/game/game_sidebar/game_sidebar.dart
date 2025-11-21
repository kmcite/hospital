import 'package:flutter/material.dart';

class GameSidebar extends StatelessWidget {
  const GameSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 0,
      child: SizedBox(
        width: 80,
        height: 500,
        child: Placeholder(
          child: Text('GameSidebar'),
        ),
      ),
    );
  }
}
