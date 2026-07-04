import 'dart:developer';

import 'package:hospital/domain/clock_repository.dart';
import 'package:hospital/utils/di.dart';
import 'package:hospital/utils/sm.dart';

final clickerProvider = provider(
  (ref) => ClickerProvider(ref(gameRepository)),
);

class ClickerProvider {
  final GameRepository gameRepository;
  ClickerProvider(this.gameRepository) {}
  void clickerTapped() {
    gameRepository.incrementClicks();
    log('clickerTapped', name: this.runtimeType.toString());
  }

  late final clicksSignal = computed(() => gameRepository.clicksSignal());
}
