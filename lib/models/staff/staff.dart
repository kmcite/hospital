import 'package:hospital/main.dart';

class Staff {
  String id = faker.guid.guid();
  String name = faker.person.name();
  // String role = faker.vehicle.model();
  // String department = faker.company.name();
  double salary = faker.randomGenerator.decimal(scale: 500, min: 50);
  // double signingBonus = faker.randomGenerator.decimal(scale: 100, min: 40);
  final isActive = signal(false);
  final count = signal(0);
  final isHired = signal(false);
  void hire() => isHired.set(true);
  void fire() => isHired.set(false);

  final dutyMaximalTime = 100;
  late final dutyAmount = signal(dutyMaximalTime);
  late final percentage = computed(() => dutyAmount() / dutyMaximalTime);
}
