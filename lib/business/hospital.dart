import 'package:hospital/domain/clock_repository.dart';
import 'package:hospital/utils/di.dart';
import 'package:hospital/utils/sm.dart';
import 'package:rearch/rearch.dart';

typedef Modifier<T> = ({
  T value,
  void Function(T) onChanged,
});

extension on SideEffectRegistrar {
  Modifier<T> signal<T>(T initialValue) {
    final (value, onChanged) = state(initialValue);
    return (
      value: value,
      onChanged: onChanged,
    );
  }
}

final darkCapsule = capsule((use) => use.signal(false));
final timeCapsule = capsule((use) => use.state(0));

final class HospitalState {
  HospitalState({
    this.time = 0,
    this.money = 0,
    this.reputation = 0,
    this.patientsTreated = 0,
    this.dark = false,
  });
  num time = 0;
  num money = 0;
  num reputation = 0;
  int patientsTreated = 0;
  bool dark = false;
  HospitalState copyWith({
    num? time,
    num? money,
    num? reputation,
    int? patientsTreated,
    bool? dark,
  }) {
    return HospitalState(
      time: time ?? this.time,
      money: money ?? this.money,
      reputation: reputation ?? this.reputation,
      patientsTreated: patientsTreated ?? this.patientsTreated,
      dark: dark ?? this.dark,
    );
  }
}

final hospitalProvider = provider(
  (ref) => HospitalProvider(ref(gameRepository)),
);

class HospitalProvider {
  final GameRepository gameRepository;
  HospitalProvider(this.gameRepository);

  final hospital = signal(HospitalState());
  late final clockSignal = computed(() => gameRepository.clockSignal());

  TreatPatient() {
    hospital((s) => s.copyWith(patientsTreated: s.patientsTreated + 1));
  }

  SpendMoney(num money) {
    hospital((s) => s.copyWith(money: s.money - money));
  }

  AddReputation(num reputation) {
    hospital((s) => s.copyWith(reputation: s.reputation + reputation));
  }

  FundMoney(int money) {
    hospital((s) => s.copyWith(money: s.money + money));
  }

  void toggleDark() {
    hospital((s) => s.copyWith(dark: !s.dark));
  }

  void pauseGame() {
    gameRepository.pauseGame();
  }
}
