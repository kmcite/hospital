import 'package:hospital/main.dart';
import 'staff.dart';

class Doctor extends Staff {
  // Doctor-specific properties
  String medicalLicenseNumber = '';
  List<String> specializations = [];
  int yearsOfExperience = 0;
  double consultationFee = 0.0;
  int maxPatientsPerDay = 20;

  // Treatment tracking
  int patientsConsultedToday = 0;
  DateTime? lastConsultationTime;

  Doctor() : super() {
    role = 'Doctor';
    _generateDoctorDetails();
  }

  Doctor.create({
    required String name,
    required String specialization,
    required double salary,
    required this.yearsOfExperience,
    this.consultationFee = 200.0,
    this.maxPatientsPerDay = 20,
    List<String>? additionalSpecializations,
  }) : super.create(
          name: name,
          role: 'Doctor',
          salary: salary,
          specialization: specialization,
          qualifications: _getDoctorQualifications(specialization),
        ) {
    this.specializations = [
      specialization,
      ...(additionalSpecializations ?? [])
    ];
    this.consultationFee = consultationFee;
    _generateDoctorDetails();
  }

  void _generateDoctorDetails() {
    if (medicalLicenseNumber.isEmpty) {
      medicalLicenseNumber =
          'MD${faker.randomGenerator.integer(99999, min: 10000)}';
    }
    if (specializations.isEmpty) {
      specializations = [_getRandomSpecialization()];
      specialization = specializations.first;
    }
    if (yearsOfExperience == 0) {
      yearsOfExperience = faker.randomGenerator.integer(30, min: 1);
    }
    if (consultationFee == 0.0) {
      consultationFee =
          faker.randomGenerator.decimal(min: 150, scale: 200); // 150-350
    }

    // Adjust salary based on experience and specialization
    if (salary == 0.0) {
      salary = _calculateSalary();
    }
  }

  double _calculateSalary() {
    double baseSalary = 80000;
    double experienceBonus = yearsOfExperience * 2000;
    double specializationBonus = specializations.length * 5000;
    return baseSalary + experienceBonus + specializationBonus;
  }

  static List<String> _getDoctorQualifications(String specialization) {
    List<String> base = ['MBBS', 'Medical License'];
    switch (specialization.toLowerCase()) {
      case 'cardiology':
        base.addAll(['MD Cardiology', 'FACC']);
        break;
      case 'neurology':
        base.addAll(['MD Neurology', 'Fellowship in Neurology']);
        break;
      case 'pediatrics':
        base.addAll(['MD Pediatrics', 'DCH']);
        break;
      case 'surgery':
        base.addAll(['MS Surgery', 'FRCS']);
        break;
      default:
        base.add('MD ${specialization.toUpperCase()}');
    }
    return base;
  }

  String _getRandomSpecialization() {
    List<String> specializations = [
      'General Medicine',
      'Cardiology',
      'Neurology',
      'Pediatrics',
      'Surgery',
      'Orthopedics',
      'Dermatology',
      'Psychiatry',
      'Emergency Medicine',
      'Internal Medicine'
    ];
    return specializations[
        faker.randomGenerator.integer(specializations.length)];
  }

  // Doctor-specific methods
  void startConsultation() {
    if (!canConsult) {
      throw StateError('Doctor cannot start consultation in current state');
    }

    startWork(baseWorkDuration);
    lastConsultationTime = DateTime.now();
  }

  void completeConsultation() {
    completeWork();
    patientsConsultedToday++;

    // Reset daily counter at midnight (simplified)
    final now = DateTime.now();
    if (lastConsultationTime != null &&
        !_isSameDay(lastConsultationTime!, now)) {
      patientsConsultedToday = 1;
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void addSpecialization(String newSpecialization) {
    if (!specializations.contains(newSpecialization)) {
      specializations.add(newSpecialization);
      qualifications.addAll(_getDoctorQualifications(newSpecialization));
    }
  }

  // Override abstract methods
  @override
  int get baseWorkDuration => 20 + (yearsOfExperience > 10 ? -5 : 0); // minutes

  @override
  String get staffType => 'Doctor';

  @override
  List<String> get requiredQualifications => ['MBBS', 'Medical License'];

  // Computed properties
  bool get canConsult =>
      canWork &&
      patientsConsultedToday < maxPatientsPerDay &&
      specializations.isNotEmpty;

  bool get hasReachedDailyLimit => patientsConsultedToday >= maxPatientsPerDay;

  double get experienceMultiplier =>
      1.0 + (yearsOfExperience * 0.02); // 2% per year

  String get primarySpecialization =>
      specializations.isNotEmpty ? specializations.first : 'General Medicine';

  @override
  String toString() {
    return 'Dr. $name ($primarySpecialization) - $statusDescription '
        '(Patients today: $patientsConsultedToday/$maxPatientsPerDay)';
  }
}
