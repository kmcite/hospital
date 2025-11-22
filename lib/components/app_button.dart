import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final IconData? icon;
  final bool isLoading;
  final bool isDisabled;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return FButton.icon(
        onPress: isDisabled || isLoading ? null : onPressed,
        child: isLoading ? CircularProgressIndicator() : Icon(icon),
      );
    }

    return FButton(
      onPress: isDisabled || isLoading ? null : onPressed,
      child: isLoading ? CircularProgressIndicator() : Text(text),
    );
  }
}
