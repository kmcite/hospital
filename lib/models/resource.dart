import 'package:objectbox/objectbox.dart';

@Entity()
class Resource {
  @Id(assignable: true)
  int id;
  String name;
  int total;
  int available;
  ResourceType type;

  Resource({
    this.id = 0,
    this.name = '',
    this.total = 0,
    this.available = 0,
    this.type = ResourceType.bed,
  });
}

enum ResourceType { bed, equipment, medicine }
