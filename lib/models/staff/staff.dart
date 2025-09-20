import 'package:hospital/main.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Staff {
  @Id()
  int id = 0;

  // Personal Information
  String name = '';
  String email = '';
  String phone = '';
  String? imageUrl;

  // Employment Details
  double salary = 0.0;
  String department = '';
  String role = '';
  List<String> qualifications = [];
  String? specialization;

  @Property(type: PropertyType.date)
  DateTime joinDate = DateTime.now();
  @Property(type: PropertyType.date)
  DateTime? lastWorkDate;

  // Employment Status
  bool isHired = false;
  bool isActive = false;
  bool isOnDuty = false;

  // Work Management
  double energyLevel = 1.0; // 0.0 to 1.0
  double workEfficiency = 1.0; // 0.0 to 2.0
  int tasksCompleted = 0;
  int totalWorkHours = 0;

  // Work State
  int workStateIndex = 0;
  @Transient()
  WorkState get workState => WorkState.values[workStateIndex];
  set workState(WorkState value) {
    workStateIndex = value.index;
  }

  // Performance Metrics
  double performanceRating = 5.0; // 1.0 to 10.0
  int patientsSeen = 0;
  double averageTaskTime = 0.0;

  Staff() {
    _generateStaffDetails();
  }

  Staff.create({
    required this.name,
    required this.role,
    required this.salary,
    this.department = '',
    this.specialization,
    List<String>? qualifications,
  }) {
    this.qualifications = qualifications ?? [];
    this.email = '${name.toLowerCase().replaceAll(' ', '.')}@hospital.com';
    this.phone = faker.phoneNumber.us();
    this.energyLevel = 1.0;
    this.workEfficiency =
        faker.randomGenerator.decimal(min: 0.8, scale: 0.4); // 0.8 to 1.2
    this.performanceRating =
        faker.randomGenerator.decimal(min: 6.0, scale: 4.0); // 6.0 to 10.0
    this.workState = WorkState.available;
  }

  void _generateStaffDetails() {
    if (name.isEmpty) name = faker.person.name();
    if (email.isEmpty)
      email = '${name.toLowerCase().replaceAll(' ', '.')}@hospital.com';
    if (phone.isEmpty) phone = faker.phoneNumber.us();
    if (department.isEmpty) department = faker.conference.name();
    if (salary == 0.0) {
      salary = faker.randomGenerator.decimal(scale: 500, min: 50);
    }
    energyLevel = 1.0;
    workEfficiency = faker.randomGenerator.decimal(min: 0.8, scale: 0.4);
    performanceRating = faker.randomGenerator.decimal(min: 6.0, scale: 4.0);
    workState = WorkState.available;
  }

  // Employment Management
  void hire() {
    isHired = true;
    isActive = true;
    workState = WorkState.available;
  }

  void fire() {
    isHired = false;
    isActive = false;
    workState = WorkState.unavailable;
  }

  void goOnDuty() {
    if (!isHired || !isActive) {
      throw StateError('Staff member must be hired and active to go on duty');
    }
    isOnDuty = true;
    workState = WorkState.onDuty;
  }

  void goOffDuty() {
    isOnDuty = false;
    workState = WorkState.available;
  }

  // Work Management
  void startWork(int estimatedDurationMinutes) {
    if (!canWork) {
      throw StateError('Staff member cannot work in current state');
    }
    workState = WorkState.working;
    lastWorkDate = DateTime.now();
  }

  void completeWork() {
    if (workState != WorkState.working) {
      throw StateError('Staff member is not currently working');
    }

    tasksCompleted++;
    patientsSeen++;

    // Reduce energy based on work efficiency
    energyLevel = (energyLevel - (0.1 / workEfficiency)).clamp(0.0, 1.0);

    if (energyLevel <= 0.2) {
      workState = WorkState.exhausted;
    } else {
      workState = WorkState.available;
    }

    // Update performance rating based on efficiency
    _updatePerformanceRating();
  }

  void takeBreak() {
    if (workState == WorkState.working) {
      throw StateError('Cannot take break while working');
    }
    workState = WorkState.onBreak;
  }

  void rest() {
    workState = WorkState.resting;
    // Gradually restore energy
    energyLevel = (energyLevel + 0.3).clamp(0.0, 1.0);

    if (energyLevel >= 0.8) {
      workState = WorkState.available;
    }
  }

  void _updatePerformanceRating() {
    if (tasksCompleted > 0) {
      double efficiency = workEfficiency;
      double energyImpact = energyLevel;
      performanceRating = ((performanceRating + efficiency + energyImpact) / 3)
          .clamp(1.0, 10.0);
    }
  }

  int get baseWorkDuration => 8 * 60; // in minutes
  String get staffType => 'Staff';
  List<String> get requiredQualifications => [];

  // Computed properties
  @Transient()
  bool get canWork =>
      isHired &&
      isActive &&
      energyLevel > 0.1 &&
      (workState == WorkState.available || workState == WorkState.onDuty);

  @Transient()
  bool get isWorking => workState == WorkState.working;

  @Transient()
  bool get isExhausted => workState == WorkState.exhausted;

  @Transient()
  bool get isResting => workState == WorkState.resting;

  @Transient()
  bool get isOnBreak => workState == WorkState.onBreak;

  @Transient()
  bool get isAvailable => workState == WorkState.available;

  @Transient()
  double get workloadCapacity => energyLevel * workEfficiency;

  @Transient()
  String get statusDescription {
    return switch (workState) {
      WorkState.available => 'Available for work',
      WorkState.working => 'Currently working',
      WorkState.onDuty => 'On duty',
      WorkState.onBreak => 'On break',
      WorkState.resting => 'Resting',
      WorkState.exhausted => 'Exhausted - needs rest',
      WorkState.unavailable => 'Unavailable',
    };
  }

  @override
  String toString() {
    return '$staffType: $name - $statusDescription (Energy: ${(energyLevel * 100).toInt()}%)';
  }
}

enum WorkState {
  available,
  working,
  onDuty,
  onBreak,
  resting,
  exhausted,
  unavailable,
}
