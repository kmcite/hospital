import 'package:hospital/main.dart';
import 'staff.dart';

class Nurse extends Staff {
  // Nurse-specific properties
  String nursingLicenseNumber = '';
  List<String> certifications = [];
  String shiftType = 'day'; // day, night, rotating
  int wardAssignment = 1; // ward number
  bool isHeadNurse = false;

  // Care tracking
  int patientsAssigned = 0;
  int maxPatientLoad = 8;
  DateTime? lastMedicationTime;

  Nurse() : super() {
    role = 'Nurse';
    _generateNurseDetails();
  }

  Nurse.create({
    required String name,
    required double salary,
    this.shiftType = 'day',
    this.wardAssignment = 1,
    this.isHeadNurse = false,
    this.maxPatientLoad = 8,
    List<String>? certifications,
  }) : super.create(
          name: name,
          role: 'Nurse',
          salary: salary,
          department: 'Ward $wardAssignment',
          qualifications: _getNurseQualifications(),
        ) {
    this.certifications = certifications ?? [];
    _generateNurseDetails();
  }

  void _generateNurseDetails() {
    if (nursingLicenseNumber.isEmpty) {
      nursingLicenseNumber =
          'RN${faker.randomGenerator.integer(99999, min: 10000)}';
    }
    if (certifications.isEmpty) {
      certifications = _getRandomCertifications();
    }
    if (shiftType == 'day' && faker.randomGenerator.boolean()) {
      shiftType =
          ['day', 'night', 'rotating'][faker.randomGenerator.integer(3)];
    }

    // Adjust max patient load based on experience and head nurse status
    if (isHeadNurse) {
      maxPatientLoad =
          (maxPatientLoad * 0.7).round(); // Head nurses have admin duties
      salary *= 1.3; // 30% salary increase
    }
  }

  static List<String> _getNurseQualifications() {
    return ['BSN', 'Nursing License', 'CPR Certification', 'First Aid'];
  }

  List<String> _getRandomCertifications() {
    List<String> available = [
      'Critical Care',
      'Pediatric Nursing',
      'Emergency Nursing',
      'Wound Care',
      'IV Therapy',
      'Medication Administration',
      'Patient Education',
      'Infection Control'
    ];

    int numCerts = faker.randomGenerator.integer(4, min: 1);
    available.shuffle();
    return available.take(numCerts).toList();
  }

  // Nurse-specific methods
  void assignToWard(int wardNumber) {
    wardAssignment = wardNumber;
    department = 'Ward $wardNumber';
  }

  void promoteToHeadNurse() {
    if (!isHeadNurse) {
      isHeadNurse = true;
      maxPatientLoad = (maxPatientLoad * 0.7).round();
      salary *= 1.3;
      certifications.add('Leadership & Management');
    }
  }

  void demoteFromHeadNurse() {
    if (isHeadNurse) {
      isHeadNurse = false;
      maxPatientLoad = (maxPatientLoad / 0.7).round();
      salary /= 1.3;
      certifications.remove('Leadership & Management');
    }
  }

  void startPatientCare() {
    if (!canProviderCare) {
      throw StateError('Nurse cannot provide care in current state');
    }

    startWork(baseWorkDuration);
  }

  void completePatientCare() {
    completeWork();
  }

  void administerMedication() {
    if (!canProviderCare) {
      throw StateError('Nurse cannot administer medication in current state');
    }

    lastMedicationTime = DateTime.now();
    startWork(15); // 15 minutes for medication administration
  }

  void addCertification(String certification) {
    if (!certifications.contains(certification)) {
      certifications.add(certification);
      // Increase efficiency with more certifications
      workEfficiency = (workEfficiency + 0.05).clamp(0.5, 2.0);
    }
  }

  void changeShift(String newShift) {
    if (['day', 'night', 'rotating'].contains(newShift)) {
      shiftType = newShift;

      // Adjust energy based on shift preference
      if (newShift == 'night') {
        energyLevel = (energyLevel - 0.1).clamp(0.0, 1.0);
      }
    }
  }

  // Override abstract methods
  @override
  int get baseWorkDuration => isHeadNurse ? 25 : 15; // minutes

  @override
  String get staffType => isHeadNurse ? 'Head Nurse' : 'Nurse';

  @override
  List<String> get requiredQualifications => ['BSN', 'Nursing License'];

  // Computed properties
  bool get canProviderCare => canWork && patientsAssigned < maxPatientLoad;

  bool get hasReachedPatientLimit => patientsAssigned >= maxPatientLoad;

  bool get isOnNightShift => shiftType == 'night';

  bool get isOnDayShift => shiftType == 'day';

  bool get isOnRotatingShift => shiftType == 'rotating';

  double get careQuality => (workEfficiency +
          (certifications.length * 0.1) +
          (isHeadNurse ? 0.2 : 0.0))
      .clamp(0.5, 2.0);

  String get shiftDescription {
    return switch (shiftType) {
      'day' => 'Day Shift (7 AM - 7 PM)',
      'night' => 'Night Shift (7 PM - 7 AM)',
      'rotating' => 'Rotating Shifts',
      _ => 'Unknown Shift',
    };
  }

  @override
  String toString() {
    String title = isHeadNurse ? 'Head Nurse' : 'Nurse';
    return '$title $name (Ward $wardAssignment, $shiftType shift) - $statusDescription '
        '(Patients: $patientsAssigned/$maxPatientLoad)';
  }
}
