import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
@CopyWith()
class Symptom {
  @Id(assignable: true)
  int id;
  String name;
  String description;
  int cost;

  Symptom({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.cost = 0,
  });
}
