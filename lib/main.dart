import 'package:flutter/material.dart';
import 'package:flutter_rearch/flutter_rearch.dart';
import 'package:hospital/business/hospital.dart';
import 'package:hospital/business/main_menu.dart';
import 'package:hospital/screens/main_menu_screen.dart';
import 'package:hospital/utils/di.dart';

void main() => runApp(
  RearchBootstrapper(
    child: ProviderScope(
      builder: (context) => HospitalGame(
        hospital: context.get(hospitalProvider),
      ),
    ),
  ),
);

// ─────────────────────────────────────────────────────────────
// App
// ─────────────────────────────────────────────────────────────

final class HospitalGame extends RearchConsumer {
  final HospitalProvider hospital;
  const HospitalGame({super.key, required this.hospital});

  @override
  Widget build(BuildContext context, use) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: use(darkCapsule).value ? .dark : .light,
      theme: ThemeData(
        brightness: Brightness.light,
        // colorSchemeSeed: Colors.indigo,
        // fontFamily: 'SUSE Mono',
        // useMaterial3: false,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        // colorSchemeSeed: Colors.yellow,
        // fontFamily: 'Martian Mono',
        // useMaterial3: false,
      ),
      home: MainMenuScreen(
        mainMenu: context.get(mainMenuProvider),
      ),
    );
  }
}
