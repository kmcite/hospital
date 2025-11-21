import 'package:hospital/application/splash/splash.dart';
// import 'package:hospital/application/splash/splash.dart';
import 'package:hospital/main.dart';

import '../domain/repositories/settings_repository.dart';

class ApplicationNotifier extends Notifier {
  late SettingsRepository settings = context.of();
  Subscription? _subscription;
  ApplicationNotifier(super.context) {
    _subscription = settings.subscribe(notifyListeners);
  }

  bool get dark => settings.settings.themeMode == .dark;

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
        themeMode: application.dark ? .dark : .light,
        home: SplashScreen(),
      ),
    );
  }
}
