import 'dart:async';

import 'package:flutter/material.dart';

class Subscription {
  final StreamSubscription subscription;
  final void Function() disposer;
  const Subscription(
    this.subscription,
    this.disposer,
  );
  void dispose() {
    subscription.cancel();
    disposer();
  }
}

class SettingsRepository extends ChangeNotifier {
  var _settings = Settings();
  Settings get settings => _settings;
  void update(Settings value) {
    _settings = value;
    notfiy(value);
  }

  final controller = StreamController<Settings>.broadcast();
  Stream<void> get stream => controller.stream;
  void notfiy(Settings settings) {
    controller.add(settings);
    notifyListeners();
  }

  void onPageChanged(int index) {
    settings.pageIndex = index;
    notfiy(settings);
  }

  Subscription subscribe(VoidCallback callback) {
    void disposer() => removeListener(callback);
    final StreamSubscription<dynamic> subscription = stream.listen(
      (_) => callback(),
    );
    addListener(callback);
    return Subscription(subscription, disposer);
  }
}

class Settings {
  bool dark = false;
  bool autoAdd = false;
  ThemeMode themeMode = ThemeMode.system;
  int pageIndex = 0;
}
