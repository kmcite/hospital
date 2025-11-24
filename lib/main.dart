import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hospital/domain/repositories/game_repository.dart';
import 'package:hospital/domain/repositories/settings_repository.dart';
import 'package:hospital/features/splash/splash.dart';
import 'package:hospital/utils/context.dart';
import 'package:hospital/utils/navigator.dart';
import 'package:hospital/utils/notifier.dart';
import 'package:hospital/domain/models/staff.dart';
import 'package:hospital/domain/models/patient.dart';
import 'package:hospital/domain/models/medical_record.dart';
import 'package:hospital/utils/notifier_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  /// init
  // final appInfo = await PackageInfo.fromPlatform();
  // final path = await getApplicationDocumentsDirectory();
  // final store = await openStore(
  //   directory: join(path.path, appInfo.appName, 'db'),
  //   );
  // );

  /// injections
  // putService(appInfo);
  // putService(store);
  // putRepository(Staffs());
  // putRepository(Patients());
  // putRepository(MedicalRecords());
  // putRepository(SettingsRepository());

  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /// app
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider.value(value: Games()),
        ListenableProvider.value(value: Staffs()),
        ListenableProvider.value(value: Patients()),
        ListenableProvider.value(value: MedicalRecords()),
        ListenableProvider(create: (context) => SettingsRepository(context)),
      ],
      child: const Application(),
    ),
  );
}

class ApplicationNotifier extends Notifier {
  late SettingsRepository settings = context.of<SettingsRepository>();
  ApplicationNotifier(super.context) {
    settings.addListener(notifyListeners);
  }

  ThemeMode get themeMode => settings.settings.themeMode;

  @override
  void dispose() {
    settings.removeListener(notifyListeners);
    super.dispose();
  }
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return NotifierProvider<ApplicationNotifier>(
      create: ApplicationNotifier.new,
      builder: (context, application) => MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigator.navigatorKey,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            brightness: Brightness.dark,
          ),
        ),
        themeMode: application.themeMode,
        home: const SplashScreen(),
      ),
    );
  }
}
