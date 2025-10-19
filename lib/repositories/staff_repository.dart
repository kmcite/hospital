import 'package:hospital/models/objectbox_models.dart';
import 'package:hospital/repositories/crud_repository.dart';
import 'package:objectbox/objectbox.dart';

class StaffRepository extends CrudRepository<StaffMember> {
  final Store store;

  StaffRepository(this.store);
}
