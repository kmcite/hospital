import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

final dark = signal(false);

void darkToggled() {
  dark.set(!dark());
}

class DarkModeButton extends StatelessWidget {
  const DarkModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 56,
      child: FilledButton.tonalIcon(
        onPressed: () => darkToggled(),
        icon: Icon(
          dark() ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          size: 28,
        ),
        label: Text(
          dark() ? "Light" : "Dark",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
