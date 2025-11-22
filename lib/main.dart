import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rearch/flutter_rearch.dart';
import 'package:hospital/application/splash/splash.dart';
import 'package:hospital/domain/repositories/game_repository.dart';
import 'package:hospital/domain/repositories/settings_repository.dart';
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
    RearchBootstrapper(
      child: MultiProvider(
        providers: [
          ListenableProvider.value(value: Games()),
          ListenableProvider.value(value: Staffs()),
          ListenableProvider.value(value: Patients()),
          ListenableProvider.value(value: MedicalRecords()),
          ListenableProvider.value(value: SettingsRepository()),
        ],
        child: const Application(),
      ),
    ),
  );
}

class ApplicationNotifier extends Notifier {
  late SettingsRepository settings = context.of();
  Subscription? _subscription;
  ApplicationNotifier(super.context) {
    _subscription = settings.subscribe(notifyListeners);
  }

  bool get dark => settings.settings.themeMode == ThemeMode.dark;

  @override
  void dispose() {
    _subscription?.dispose();
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
        theme: ThemeData.light(),
        builder: (context, child) => FTheme(
          data: application.dark ? FThemes.green.dark : FThemes.green.light,
          child: child!,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: application.dark ? ThemeMode.dark : ThemeMode.light,
        home: const SplashScreen(),
      ),
    );
  }
}
