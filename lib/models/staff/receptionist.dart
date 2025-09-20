import 'package:hospital/main.dart';
import 'staff.dart';

class Receptionist extends Staff {
  // Receptionist-specific properties
  List<String> languages = [];
  bool canHandleInsurance = false;
  bool canScheduleAppointments = true;
  double processingSpeed = 1.0; // multiplier for task completion

  // Reception tracking
  int patientsProcessedToday = 0;
  int maxPatientsPerHour = 15;
  DateTime? lastPatientTime;
  int appointmentsScheduled = 0;

  Receptionist() : super() {
    role = 'Receptionist';
    _generateReceptionistDetails();
  }

  Receptionist.create({
    required String name,
    required double salary,
    this.canHandleInsurance = false,
    this.canScheduleAppointments = true,
    this.maxPatientsPerHour = 15,
    List<String>? languages,
  }) : super.create(
          name: name,
          role: 'Receptionist',
          salary: salary,
          department: 'Reception',
          qualifications: _getReceptionistQualifications(),
        ) {
    this.languages = languages ?? ['English'];
    _generateReceptionistDetails();
  }

  void _generateReceptionistDetails() {
    if (languages.isEmpty) {
      languages = _getRandomLanguages();
    }

    // Random chance for additional skills
    if (faker.randomGenerator.boolean()) {
      canHandleInsurance = true;
      qualifications.add('Insurance Processing');
    }

    // Processing speed based on experience (simulated)
    processingSpeed =
        faker.randomGenerator.decimal(min: 0.8, scale: 0.6); // 0.8 to 1.4
  }

  static List<String> _getReceptionistQualifications() {
    return [
      'Customer Service',
      'Computer Skills',
      'Phone Etiquette',
      'Medical Terminology'
    ];
  }

  List<String> _getRandomLanguages() {
    List<String> available = [
      'English',
      'Spanish',
      'French',
      'German',
      'Italian',
      'Portuguese',
      'Chinese',
      'Japanese',
      'Arabic',
      'Hindi'
    ];

    int numLanguages = faker.randomGenerator.integer(3, min: 1);
    available.shuffle();
    return available.take(numLanguages).toList();
  }

  // Receptionist-specific methods
  void processPatient() {
    if (!canProcessPatients) {
      throw StateError('Receptionist cannot process patients in current state');
    }

    startWork((baseWorkDuration / processingSpeed).round());
    lastPatientTime = DateTime.now();
    patientsProcessedToday++;
  }

  void completePatientProcessing() {
    completeWork();
  }

  void scheduleAppointment() {
    if (!canScheduleAppointments) {
      throw StateError(
          'Receptionist is not authorized to schedule appointments');
    }

    if (!canProcessPatients) {
      throw StateError(
          'Receptionist cannot schedule appointments in current state');
    }

    startWork(10); // 10 minutes for appointment scheduling
    appointmentsScheduled++;
  }

  void processInsuranceClaim() {
    if (!canHandleInsurance) {
      throw StateError('Receptionist is not trained for insurance processing');
    }

    if (!canProcessPatients) {
      throw StateError(
          'Receptionist cannot process insurance in current state');
    }

    startWork(20); // 20 minutes for insurance processing
  }

  void addLanguage(String language) {
    if (!languages.contains(language)) {
      languages.add(language);
      // Improve efficiency with more languages
      processingSpeed = (processingSpeed + 0.05).clamp(0.5, 2.0);
    }
  }

  void enableInsuranceProcessing() {
    if (!canHandleInsurance) {
      canHandleInsurance = true;
      qualifications.add('Insurance Processing');
      salary *= 1.1; // 10% salary increase
    }
  }

  void disableInsuranceProcessing() {
    if (canHandleInsurance) {
      canHandleInsurance = false;
      qualifications.remove('Insurance Processing');
      salary /= 1.1;
    }
  }

  // Override abstract methods
  @override
  int get baseWorkDuration => 8; // minutes

  @override
  String get staffType => 'Receptionist';

  @override
  List<String> get requiredQualifications =>
      ['Customer Service', 'Computer Skills'];

  // Computed properties
  bool get canProcessPatients => canWork && !hasReachedHourlyLimit;

  bool get hasReachedHourlyLimit {
    if (lastPatientTime == null) return false;

    final now = DateTime.now();
    final timeDiff = now.difference(lastPatientTime!);

    if (timeDiff.inHours >= 1) {
      // Reset counter if more than an hour has passed
      patientsProcessedToday = 0;
      return false;
    }

    // Check if reached hourly limit (simplified)
    return patientsProcessedToday >= maxPatientsPerHour;
  }

  bool get isMultilingual => languages.length > 1;

  double get serviceQuality => (processingSpeed +
          (languages.length * 0.1) +
          (canHandleInsurance ? 0.2 : 0.0))
      .clamp(0.5, 2.0);

  String get languagesSupported => languages.join(', ');

  @override
  String toString() {
    List<String> skills = [];
    if (canHandleInsurance) skills.add('Insurance');
    if (canScheduleAppointments) skills.add('Scheduling');
    if (isMultilingual) skills.add('Multilingual');

    String skillsStr = skills.isNotEmpty ? ' (${skills.join(', ')})' : '';

    return 'Receptionist $name$skillsStr - $statusDescription '
        '(Processed today: $patientsProcessedToday)';
  }
}
