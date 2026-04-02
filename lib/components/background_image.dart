import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Icon(
        Icons.local_hospital_rounded,
        size: 300,
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
      ),
    );
  }
}
