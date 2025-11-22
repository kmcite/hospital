import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
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
    return FHeader(
      title: Text(title),
      suffixes:
          actions ??
          [
            FHeaderAction.x(onPress: navigator.back),
          ],
    );
  }
}
