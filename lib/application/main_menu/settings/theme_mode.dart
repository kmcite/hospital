import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
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
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('THEME MODE'),
            for (final themeMode in ThemeMode.values)
              FTile(
                onPress: theme.isSelected(themeMode)
                    ? null
                    : () => theme.setThemeMode(themeMode),
                title: Text(themeMode.name.toUpperCase()),
                suffix: theme.isSelected(themeMode) ? Icon(Icons.done) : null,
              ),
          ],
        );
      },
    );
  }
}
