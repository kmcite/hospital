import 'package:hospital/main.dart';

class Receipt {
  String id;
  String details;
  double balance;
  Receipt({
    String? customId,
    this.balance = 150000,
    this.details = '',
  }) : id = customId ?? faker.guid.guid();
}
