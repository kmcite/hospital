import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class BaseScreen extends StatelessWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget child;

  const BaseScreen({
    super.key,
    this.title,
    this.actions,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: title != null
          ? FHeader(
              title: Text(title!),
              suffixes: actions ?? [],
            )
          : null,
      child: child,
    );
  }
}
