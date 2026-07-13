import 'package:faker/faker.dart';

enum StaffRole {
  receptionist('Receptionist', 180, 420),
  doctor('Doctor', 720, 1600),
  nurse('Nurse', 340, 720),
  ota('OT Assistant', 280, 620);

  const StaffRole(this.label, this.salary, this.signingBonus);

  final String label;
  final int salary;
  final int signingBonus;

  int get firingCost => salary * 3;
}

class Staff {
  Staff({
    String? id,
    String? name,
    StaffRole? role,
    DateTime? hiredAt,
  }) : id = id ?? faker.guid.guid(),
       name = name ?? faker.person.name(),
       role = role ?? faker.randomGenerator.element(StaffRole.values),
       hiredAt = hiredAt;

  final String id;
  final String name;
  final StaffRole role;
  final DateTime? hiredAt;

  int get salary => role.salary;
  int get signingBonus => role.signingBonus;
  int get firingCost => role.firingCost;

  Staff hired() =>
      Staff(id: id, name: name, role: role, hiredAt: DateTime.now());
}
