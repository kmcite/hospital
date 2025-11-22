import 'package:hospital/utils/in_memory_collection.dart';
import 'package:hospital/utils/model.dart';

class Staffs extends InMemoryCollection<StaffModel> {}

typedef StaffMemberId = int;

class StaffModel extends Model {
  // @Id()
  @override
  StaffMemberId id;
  final String name;
  final String role;
  final String department;
  final String contactNumber;
  final String email;
  // @Property(type: PropertyType.date)
  final DateTime joinDate;
  final bool isActive;

  StaffModel({
    this.id = 0,
    required this.name,
    required this.role,
    required this.department,
    required this.contactNumber,
    required this.email,
    DateTime? joinDate,
    bool? isActive,
  }) : joinDate = joinDate ?? DateTime.now(),
       isActive = isActive ?? true;

  StaffModel copyWith({
    int? id,
    String? name,
    String? role,
    String? department,
    String? contactNumber,
    String? email,
    DateTime? joinDate,
    bool? isActive,
  }) {
    return StaffModel(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      department: department ?? this.department,
      contactNumber: contactNumber ?? this.contactNumber,
      email: email ?? this.email,
      joinDate: joinDate ?? this.joinDate,
      isActive: isActive ?? this.isActive,
    );
  }
}
