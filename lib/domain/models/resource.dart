import 'package:hospital/main.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Resource extends Model {
  @Id()
  int id;
  String name;
  int total;
  int available;
  int typeIndex = 0;
  @Transient()
  ResourceType get type => ResourceType.values[typeIndex];
  set type(ResourceType type) => typeIndex = type.index;

  Resource({
    this.id = 0,
    this.name = '',
    this.total = 0,
    this.available = 0,
  });
}

enum ResourceType { bed, equipment, medicine }
