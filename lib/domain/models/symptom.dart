import 'package:objectbox/objectbox.dart';

@Entity()
class Symptom {
  @Id()
  int id = 0;
  String name = '';
  String description = '';
  int cost = 0;
}
