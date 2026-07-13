import 'package:hospital/apis/events.dart';
import 'package:hospital/models/patient.dart';
import 'package:hospital/utils/messaging.dart';
import 'package:hospital/utils/provider.dart';
import 'package:signals/signals.dart';

final patientsProvider = inject(
  (ref) => PatientsProvider(),
);

final patientsMap = mapSignal<int, Patient>();
final patientsCount = computed(() => patientsMap().length);

class PatientsProvider {
  late final canPatientBeTreated = computed(() => patients.value > 0);
  final patients = signal(0);
  PatientsProvider() {
    listen<PatientArrivedAtHospital>((e) {
      final pt = Patient();
      patientsMap((current) => Map.of(current)..[pt.id] = pt);
    });
    listen<PatientTreated>((e) {
      send(CollectFeeFromPatient());
    });
    listen<PatientDischargedHome>((e) {
      patientsMap((current) => Map.of(current)..remove(e.id));
    });
  }
}
