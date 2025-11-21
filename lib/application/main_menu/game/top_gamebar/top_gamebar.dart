import 'package:hospital/domain/repositories/settings_repository.dart';
import 'package:hospital/main.dart';

class TopGamebarNotifier extends Notifier {
  late SettingsRepository settingsRepository = context.of();
  TopGamebarNotifier(super.context) {
    settingsRepository.subscribe(notifyListeners);
  }
  int get pageViewIndex => settingsRepository.settings.pageIndex;
  void onIndexChanged(int value) {
    settingsRepository.onPageChanged(value);
  }
}

class TopGamebar extends StatelessWidget {
  const TopGamebar({super.key});

  @override
  Widget build(BuildContext context) {
    return NotifierProvider(
      create: TopGamebarNotifier.new,
      builder: (context, topGameBar) => FBottomNavigationBar(
        index: topGameBar.pageViewIndex,
        onChange: topGameBar.onIndexChanged,
        children: [
          FBottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: Text('Statistics'),
          ),
          FBottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: Text('Departments'),
          ),
        ],
      ),
    );
  }
}
