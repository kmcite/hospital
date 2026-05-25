import 'package:flutter/material.dart';

final darkMode = ValueNotifier(false);

void darkToggled() {
  darkMode.value = !darkMode.value;
}

class DarkModeButton extends StatelessWidget {
  const DarkModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: darkMode,
      builder: (context, value, child) {
        return SizedBox(
          width: 220,
          height: 56,
          child: FilledButton.tonalIcon(
            onPressed: () => darkToggled(),
            icon: Icon(
              value ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              size: 28,
            ),
            label: Text(
              value ? "Light" : "Dark",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: .circular(16),
              ),
            ),
          ),
        );
      },
    );
  }
}
