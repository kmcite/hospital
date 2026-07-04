import 'package:flutter/material.dart';

extension NavigationContext on BuildContext {
  NavigatorState get state => Navigator.of(this);
  void pop() {
    state.pop();
  }

  void push(Widget child) {
    state.push(MaterialPageRoute(builder: (context) => child));
  }

  void pushReplacement(Widget child) {
    state.pushReplacement(MaterialPageRoute(builder: (context) => child));
  }

  void pushAndRemoveUntil(
    Widget child,
    bool Function(Route<dynamic>) predicate,
  ) {
    state.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => child),
      predicate,
    );
  }

  void pushDialog(Widget child) {
    showDialog(
      context: this,
      builder: (context) => child,
    );
  }

  void pushBottomSheet(Widget child) {
    showBottomSheet(
      context: this,
      builder: (context) => child,
    );
  }

  void backUntil(bool Function(Route<dynamic>) predicate) {
    state.popUntil(predicate);
  }

  void backToFirst() {
    state.popUntil((route) => route.isFirst);
  }

  Future<T?> pushForResult<T>(Widget page) {
    return state.push<T>(MaterialPageRoute(builder: (_) => page));
  }
}
