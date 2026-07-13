import 'package:hospital/utils/provider.dart';
import 'package:signals/signals.dart';

final loadGameProvider = inject((ref) => LoadGameProvider());

class LoadGameProvider {
  final availableGames = listSignal([
    'Game 1',
    'Game 2',
    'Game 3',
  ]);
  late final canLoadGame = computed(() => selectedGame.value != null);
  final selectedGame = nullSignal<String>();
  void onSelectedGameChanged(String game) {
    selectedGame.value = game;
  }
}
