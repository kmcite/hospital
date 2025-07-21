import 'package:hospital/main.dart';

final _medications = mapSignal<String, Medication>({});
final medications = computed(() => _medications.values);
final allMedicationsQuantity = computed(
  () => medications.value.fold(
    0,
    (prev, next) => prev + next.amount,
  ),
);

class Medication {
  String id = faker.guid.guid();
  String name = faker.conference.name();
  int amount = 10;
}

void put_medication(Medication medication) {
  _medications.putIfAbsent(
    medication.id,
    () => medication,
  );
}

void remove_medication(String id) {
  _medications.remove(id);
}
