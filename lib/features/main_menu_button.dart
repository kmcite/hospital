import 'package:flutter/material.dart';
import 'package:hospital/utils/sm.dart';

class MainMenuButton extends UI {
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;

  const MainMenuButton({
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon),
              const SizedBox(width: 8),
              Text(
                text,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
