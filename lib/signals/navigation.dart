import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void navigateTo(Widget page) {
  navigatorKey.currentState?.push(
    MaterialPageRoute(builder: (context) => page),
  );
}

void navigateUntill(Widget page) {
  navigatorKey.currentState?.pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => page),
    (route) => false,
  );
}

void navigateBack<T>([T? result]) {
  navigatorKey.currentState?.pop(result);
}

Future<T?> navigateToDialog<T>(Widget page) {
  final context = navigatorKey.currentContext;
  if (context == null) {
    throw Exception('Navigator key is not initialized');
  } else {
    return showDialog<T>(
      context: context,
      builder: (context) => page,
    );
  }
}
