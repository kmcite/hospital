import 'package:objectbox/objectbox.dart';

@Entity()
class Receipt {
  @Id()
  int id = 0;
  Map<String, String> metadata = {};
  double balance = 0;
  @Property(type: PropertyType.date)
  late DateTime createdOn;

  Receipt({
    this.metadata = const {},
    this.balance = 0,
  }) {
    createdOn = DateTime.now();
  }
}
