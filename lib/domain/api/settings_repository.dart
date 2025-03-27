import 'package:hospital/domain/models/settings.dart';
import 'package:hospital/utils/api.dart';

final settingsRepository = signal(Settings());

// class SettingsRepository {
//   // final settingsRM = signal(
//   //   Settings(),
//   //   // persist: () => PersistState(
//   //   //   key: 'settings',
//   //   //   toJson: (s) => jsonEncode(s.toJson()),
//   //   //   fromJson: (json) => Settings.fromJson(jsonDecode(json)),
//   //   // ),
//   // );
//   // Modifier<Settings> get settings => settingsRepository;

//   // void funds(int amountToAddToFunds) {
//   //   settings(settings()..funds += amountToAddToFunds);
//   // }

//   // void charity(int amountToAddToFunds) {
//   //   settings(settings()..charity += amountToAddToFunds);
//   // }
// }
