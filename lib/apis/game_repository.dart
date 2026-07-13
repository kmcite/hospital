import 'dart:async';

import 'package:hospital/utils/provider.dart';
import 'package:signals/signals.dart';

final gameRepositoryProvider = inject(
  (ref) => GameRepository(),
);

/// v0.2 mvp
class GameRepository {
  Timer? timer;
  final game = signal<GameModel>(
    GameModel(),
    debugLabel: 'game',
  );

  GameRepository() {
    // timer = Timer.periodic(
    //   Duration(seconds: 1),
    //   (timer) {
    //     if (game().running) {
    //       game(
    //         (game) => game.copyWith(
    //           money: game.money + 1,
    //         ),
    //       );
    //     }
    //   },
    // );
  }
}

class GameModel({
  final num money = 0,
  final int patientsAssessed = 0,
  final int hospitalLevel = 0,
  final int staffCount = 0,
  final int incomePerSecond = 1,
  final bool running = true,
}) {
  GameModel copyWith({
    num? money,
    int? patientsAssessed,
    int? hospitalLevel,
    int? staffCount,
    int? incomePerSecond,
    bool? running,
  }) {
    return GameModel(
      money: money ?? this.money,
      patientsAssessed: patientsAssessed ?? this.patientsAssessed,
      hospitalLevel: hospitalLevel ?? this.hospitalLevel,
      staffCount: staffCount ?? this.staffCount,
      incomePerSecond: incomePerSecond ?? this.incomePerSecond,
      running: running ?? this.running,
    );
  }
}
