import 'package:flutter/material.dart';
import 'package:hospital/business/dark.dart';
import 'package:hospital/screens/game_menu_screen.dart';
import 'package:hospital/screens/game_screen.dart';
import 'package:hospital/screens/load_game_dialog.dart';
import 'package:hospital/screens/settings_screen.dart';
import 'package:hospital/utils/provider.dart';
import 'package:objectbox/objectbox.dart' show Store;
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'package:signals/signals.dart';
import 'package:yaru/yaru.dart';

import 'objectbox.g.dart' show openStore;

late Store store;

void main() async {
  // Signal.observer = LoggingSignalObserver();
  final directory = await getApplicationDocumentsDirectory();
  store = await openStore(
    directory: join(directory.path, 'hospital'),
  );
  runApp(
    RefScope(child: HospitalGame()),
  );
}

final class HospitalGame extends SignalConsumer {
  const HospitalGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: darkRead.darkSignal.choose(.dark, .light),
      theme: yaruLight,
      darkTheme: yaruDark,
      home: PageView(
        children: [
          GameScreen(),
          SettingsScreen(),
          GameMenuScreen(),
          LoadGameDialog(),
        ],
      ),
    );
  }
}
