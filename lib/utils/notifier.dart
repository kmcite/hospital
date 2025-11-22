import 'package:flutter/material.dart';

abstract class Notifier extends ChangeNotifier {
  final BuildContext context;

  Notifier(this.context);
}
