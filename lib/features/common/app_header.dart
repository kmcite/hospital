import 'package:flutter/material.dart';
import 'package:hospital/utils/navigator.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final List<Widget>? actions;

  const AppHeader({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions:
          actions ??
          [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: navigator.back,
            ),
          ],
    );
  }
}
