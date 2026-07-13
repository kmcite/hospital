import 'package:objectbox/objectbox.dart';

@Entity()
class Patient extends Model {
  @override
  @Id()
  int id = 0;
  bool isChitGiven = false;
  bool isTreated = false;
}

abstract class Model {
  int get id;
}
