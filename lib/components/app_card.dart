import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class AppCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final List<Widget>? children;

  const AppCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    if (children != null && children!.isNotEmpty) {
      return FCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FTile(
              title: Text(title),
              subtitle: Text(subtitle),
              suffix: trailing,
              onPress: onTap,
            ),
            ...children!,
          ],
        ),
      );
    }

    return FCard(
      child: FTile(
        title: Text(title),
        subtitle: Text(subtitle),
        suffix: trailing,
        onPress: onTap,
      ),
    );
  }
}
