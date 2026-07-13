import 'package:hospital/apis/events.dart';
import 'package:hospital/utils/messaging.dart';
import 'package:hospital/utils/provider.dart';
import 'package:signals/signals.dart';

final hospitalRM = inject(
  (ref) => HospitalController(),
);

class HospitalController {
  HospitalController() {
    listen<TreatPatient>((e) {});
    listen<SpendMoney>((e) {});
    listen<AddReputation>((e) {});
    listen<FundMoney>((e) {});
  }
}

final receptionistRM = inject((ref) => Receptionist());

class Receptionist {
  final money = signal<num>(0.0);
  final patientFee = signal<num>(200);
  Receptionist() {
    listen<CollectFeeFromPatient>((e) {
      money((money) => money + patientFee.value);
    });
  }
}
