import 'package:hospital/main.dart';

class Receipt {
  String id;
  Map<String, dynamic> metadata;
  double balance;
  Receipt({
    String? customId,
    this.balance = 150000,
    this.metadata = const {},
  }) : id = customId ?? faker.guid.guid();
}
