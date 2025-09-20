import 'package:objectbox/objectbox.dart';
import 'staff/staff.dart';
import 'reception.dart';

@Entity()
class Patient {
  @Id()
  int id = 0;

  String name = '';
  String complaints = '';
  String urgencyLevel = 'low'; // low, medium, high, critical

  // Timestamps
  @Property(type: PropertyType.date)
  DateTime createdAt = DateTime.now();
  @Property(type: PropertyType.date)
  DateTime? updatedAt;
  @Property(type: PropertyType.date)
  DateTime? admittedAt;
  @Property(type: PropertyType.date)
  DateTime? dischargedAt;

  // Status management
  int statusIndex = 0;
  @Transient()
  PatientStatus get status => PatientStatus.values[statusIndex];
  set status(PatientStatus value) {
    statusIndex = value.index;
    updatedAt = DateTime.now();
  }

  // Financial
  double totalBill = 0.0;
  double amountPaid = 0.0;
  bool isInsured = false;

  // Satisfaction and progress tracking
  double satisfactionScore = 100.0; // 0-100
  int waitingTimeMinutes = 0;
  String notes = '';

  // Relationships
  final assignedDoctor = ToOne<Staff>();
  final assignedNurse = ToOne<Staff>();
  final receptions = ToMany<Reception>();

  // Computed properties
  @Transient()
  bool get isWaiting => status == PatientStatus.waiting;

  @Transient()
  bool get isAdmitted => status == PatientStatus.admitted;

  @Transient()
  bool get isUnderTreatment => status == PatientStatus.underTreatment;

  @Transient()
  bool get isReadyForDischarge => status == PatientStatus.readyForDischarge;

  @Transient()
  bool get isDischarged => status == PatientStatus.discharged;

  @Transient()
  bool get isReferred => status == PatientStatus.referred;

  @Transient()
  bool get hasOutstandingBill => totalBill > amountPaid;

  @Transient()
  UrgencyLevel get urgency => UrgencyLevel.values.firstWhere(
        (level) => level.name == urgencyLevel,
        orElse: () => UrgencyLevel.low,
      );

  @Transient()
  Duration get waitingTime => DateTime.now().difference(createdAt);

  @Transient()
  Duration? get treatmentDuration {
    if (admittedAt == null) return null;
    final endTime = dischargedAt ?? DateTime.now();
    return endTime.difference(admittedAt!);
  }

  // Factory constructors
  Patient.create({
    required String name,
    required String complaints,
    UrgencyLevel urgency = UrgencyLevel.low,
    bool isInsured = false,
  }) {
    this.name = name;
    this.complaints = complaints;
    this.urgencyLevel = urgency.name;
    this.isInsured = isInsured;
    this.satisfactionScore = 100.0;
    this.status = PatientStatus.waiting;
  }

  Patient();

  // Business methods
  void admit() {
    if (status != PatientStatus.waiting) {
      throw StateError('Patient must be waiting to be admitted');
    }
    status = PatientStatus.admitted;
    admittedAt = DateTime.now();
  }

  void startTreatment() {
    if (status != PatientStatus.admitted) {
      throw StateError('Patient must be admitted to start treatment');
    }
    status = PatientStatus.underTreatment;
  }

  void readyForDischarge() {
    if (status != PatientStatus.underTreatment) {
      throw StateError(
          'Patient must be under treatment to be ready for discharge');
    }
    status = PatientStatus.readyForDischarge;
  }

  void discharge() {
    if (status != PatientStatus.readyForDischarge) {
      throw StateError('Patient must be ready for discharge');
    }
    status = PatientStatus.discharged;
    dischargedAt = DateTime.now();
  }

  void refer(String reason) {
    status = PatientStatus.referred;
    notes = 'Referred: $reason';
  }

  void addPayment(double amount) {
    amountPaid += amount;
    updatedAt = DateTime.now();
  }

  void updateSatisfaction(double score) {
    satisfactionScore = score.clamp(0.0, 100.0);
    updatedAt = DateTime.now();
  }

  void assignDoctor(Staff doctor) {
    assignedDoctor.target = doctor;
    updatedAt = DateTime.now();
  }

  void assignNurse(Staff nurse) {
    assignedNurse.target = nurse;
    updatedAt = DateTime.now();
  }
}

enum PatientStatus {
  waiting,
  admitted,
  underTreatment,
  readyForDischarge,
  discharged,
  referred,
}

enum UrgencyLevel {
  low(priority: 1, color: 'green', waitTimeMinutes: 60),
  medium(priority: 2, color: 'yellow', waitTimeMinutes: 30),
  high(priority: 3, color: 'orange', waitTimeMinutes: 15),
  critical(priority: 4, color: 'red', waitTimeMinutes: 5);

  const UrgencyLevel({
    required this.priority,
    required this.color,
    required this.waitTimeMinutes,
  });

  final int priority;
  final String color;
  final int waitTimeMinutes;
}
