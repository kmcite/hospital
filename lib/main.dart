export 'package:flutter/material.dart';
export 'package:forui/forui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rearch/flutter_rearch.dart';
import 'package:hospital/application/application.dart';
import 'package:hospital/domain/repositories/game_repository.dart';
import 'package:hospital/main.dart';
import 'package:hospital/domain/repositories/settings_repository.dart';
export 'package:hospital/utils/navigator.dart';
export 'package:provider/provider.dart'
    show ListenableProvider, MultiProvider, WatchContext, ReadContext;
export 'package:hospital/utils/notifier_provider.dart' show NotifierProvider;
// export 'package:hospital/utils/locator.dart';
export 'package:hospital/domain/models/models.dart';
export 'package:hospital/utils/context.dart';

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
        child: Application(),
      ),
    ),
  );
}
