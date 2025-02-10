import 'dart:math';

class StaffMember {
  final String name;
  final String role;
  final int salary;
  final double efficiency;
  final double quality;

  StaffMember({
    required this.name,
    required this.role,
    required this.salary,
    required this.efficiency,
    required this.quality,
  });

  static StaffMember generateStaff(String role) {
    final names = ["Dr. Smith", "Nurse Adams", "Dr. Gupta", "Nurse Lee"];
    final name = names[Random().nextInt(names.length)];
    int salary = role == "Doctor" ? 1000 : 500;
    double efficiency = role == "Doctor" ? 1.2 : 1.1;
    double quality = role == "Doctor" ? 1.1 : 1.05;
    return StaffMember(
      name: name,
      role: role,
      salary: salary,
      efficiency: efficiency,
      quality: quality,
    );
  }
}
