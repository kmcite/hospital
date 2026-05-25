import 'package:faker/faker.dart' show faker;

class Patient {
  String id = faker.guid.guid();
  String name = faker.person.name();
  int money = 20;
  @override
  String toString() {
    return "Patient(name: $name, money: $money)";
  }

  int pay() {
    final payment = 10;
    money -= payment;
    return payment;
  }
}
