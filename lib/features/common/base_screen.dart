import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: title != null
          ? AppBar(
              title: Text(title!),
              actions: actions ?? [],
            )
          : null,
      body: child,
    );
  }
}
