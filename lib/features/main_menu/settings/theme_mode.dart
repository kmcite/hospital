import 'package:flutter/material.dart';
import 'package:hospital/domain/repositories/settings_repository.dart';
import 'package:hospital/utils/context.dart';
import 'package:hospital/utils/notifier_provider.dart';

class ThemeNotifier extends ChangeNotifier {
  final BuildContext context;
  ThemeNotifier(this.context);
  late ThemeMode _themeMode = settings.themeMode;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
    settingsRepository.update(settings..themeMode = themeMode);
  }

  late SettingsRepository settingsRepository = context.of();
  Settings get settings => settingsRepository.settings;
  bool isSelected(ThemeMode themeMode) => _themeMode == themeMode;
}

class ThemeModeView extends StatelessWidget {
  const ThemeModeView({super.key});

  @override
  Widget build(BuildContext context) {
    return NotifierProvider(
      create: ThemeNotifier.new,
      builder: (context, theme) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.brightness_6),
                const SizedBox(width: 8),
                const Text(
                  'THEME MODE',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...ThemeMode.values.map(
              (themeMode) => Card(
                child: ListTile(
                  title: Text(themeMode.name.toUpperCase()),
                  leading: Radio<ThemeMode>(
                    value: themeMode,
                    groupValue: theme.themeMode,
                    onChanged: (value) {
                      if (value != null) {
                        theme.setThemeMode(value);
                      }
                    },
                  ),
                  onTap: () => theme.setThemeMode(themeMode),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
