import 'package:objectbox/objectbox.dart';
import 'package:hospital/main.dart';
import 'staff/staff.dart';
import 'patient.dart';
import 'medication.dart';

@Entity()
class Consultation {
  @Id()
  int id = 0;

  // Consultation details
  String consultationId = '';
  String chiefComplaint = '';
  String diagnosis = '';
  String treatment = '';
  String notes = '';

  // Timing
  @Property(type: PropertyType.date)
  DateTime startTime = DateTime.now();
  @Property(type: PropertyType.date)
  DateTime? endTime;
  int estimatedDurationMinutes = 30;

  // Status tracking
  int statusIndex = 0;
  @Transient()
  ConsultationStatus get status => ConsultationStatus.values[statusIndex];
  set status(ConsultationStatus value) {
    statusIndex = value.index;
  }

  // Financial
  double consultationFee = 0.0;
  double additionalCharges = 0.0;
  bool isPaid = false;

  // Options and procedures
  List<int> optionIndexes = [];
  @Transient()
  List<ConsultationOption> get options =>
      optionIndexes.map((i) => ConsultationOption.values[i]).toList();
  set options(List<ConsultationOption> value) {
    optionIndexes = value.map((option) => option.index).toList();
  }

  // Urgency and priority
  int priorityIndex = 0;
  @Transient()
  ConsultationPriority get priority =>
      ConsultationPriority.values[priorityIndex];
  set priority(ConsultationPriority value) {
    priorityIndex = value.index;
  }

  // Relationships
  final patient = ToOne<Patient>();
  final doctor = ToOne<Staff>();
  final nurse = ToOne<Staff>();
  final medications = ToMany<Medication>();

  Consultation() {
    consultationId = 'CONS${faker.randomGenerator.integer(99999, min: 10000)}';
    status = ConsultationStatus.scheduled;
    priority = ConsultationPriority.normal;
  }

  Consultation.create({
    required Patient patient,
    required Staff doctor,
    this.chiefComplaint = '',
    this.estimatedDurationMinutes = 30,
    ConsultationPriority priority = ConsultationPriority.normal,
  }) {
    this.patient.target = patient;
    this.doctor.target = doctor;
    this.priority = priority;
    this.consultationId =
        'CONS${faker.randomGenerator.integer(99999, min: 10000)}';
    this.status = ConsultationStatus.scheduled;
    this.consultationFee = (doctor as dynamic).consultationFee ?? 200.0;
  }

  // Business methods
  void start() {
    if (status != ConsultationStatus.scheduled) {
      throw StateError('Consultation must be scheduled to start');
    }
    status = ConsultationStatus.inProgress;
    startTime = DateTime.now();
  }

  void complete({
    required String diagnosis,
    required String treatment,
    String notes = '',
    List<ConsultationOption>? procedures,
  }) {
    if (status != ConsultationStatus.inProgress) {
      throw StateError('Consultation must be in progress to complete');
    }

    this.diagnosis = diagnosis;
    this.treatment = treatment;
    this.notes = notes;

    if (procedures != null) {
      this.options = procedures;
    }

    status = ConsultationStatus.completed;
    endTime = DateTime.now();
  }

  void cancel(String reason) {
    if (status == ConsultationStatus.completed) {
      throw StateError('Cannot cancel completed consultation');
    }
    status = ConsultationStatus.cancelled;
    notes = 'Cancelled: $reason';
  }

  void addMedication(Medication medication) {
    medications.add(medication);
    // additionalCharges += medication.cost;
  }

  void removeMedication(Medication medication) {
    if (medications.remove(medication)) {
      // additionalCharges -= medication.cost;
    }
  }

  void markAsPaid() {
    isPaid = true;
  }

  // Computed properties
  @Transient()
  Duration? get actualDuration {
    if (endTime == null) return null;
    return endTime!.difference(startTime);
  }

  @Transient()
  Duration get estimatedDuration => Duration(minutes: estimatedDurationMinutes);

  @Transient()
  double get totalCost => consultationFee + additionalCharges;

  @Transient()
  bool get isCompleted => status == ConsultationStatus.completed;

  @Transient()
  bool get isInProgress => status == ConsultationStatus.inProgress;

  @Transient()
  bool get isScheduled => status == ConsultationStatus.scheduled;

  @Transient()
  bool get isCancelled => status == ConsultationStatus.cancelled;

  @Transient()
  int get totalDurationMinutes {
    int baseDuration = estimatedDurationMinutes;
    int optionsDuration =
        options.fold(0, (sum, option) => sum + option.duration);
    return baseDuration + optionsDuration;
  }

  @Transient()
  String get statusDescription {
    return switch (status) {
      ConsultationStatus.scheduled => 'Scheduled',
      ConsultationStatus.inProgress => 'In Progress',
      ConsultationStatus.completed => 'Completed',
      ConsultationStatus.cancelled => 'Cancelled',
    };
  }

  @Transient()
  String get priorityDescription {
    return switch (priority) {
      ConsultationPriority.low => 'Low Priority',
      ConsultationPriority.normal => 'Normal Priority',
      ConsultationPriority.high => 'High Priority',
      ConsultationPriority.urgent => 'Urgent',
      ConsultationPriority.emergency => 'Emergency',
    };
  }

  @override
  String toString() {
    return 'Consultation $consultationId - ${patient.target?.name ?? "Unknown Patient"} '
        'with Dr. ${doctor.target?.name ?? "Unknown Doctor"} - $statusDescription';
  }
}

enum ConsultationStatus {
  scheduled,
  inProgress,
  completed,
  cancelled,
}

enum ConsultationPriority {
  low,
  normal,
  high,
  urgent,
  emergency,
}

enum ConsultationOption {
  physicalExamination(duration: 15, cost: 50),
  bloodPressureCheck(duration: 5, cost: 20),
  temperatureCheck(duration: 3, cost: 10),
  bloodTest(duration: 10, cost: 100),
  xray(duration: 20, cost: 200),
  ultrasound(duration: 30, cost: 300),
  ecg(duration: 15, cost: 150),
  injection(duration: 5, cost: 25),
  prescription(duration: 10, cost: 0),
  referral(duration: 15, cost: 0),
  admission(duration: 30, cost: 500),
  discharge(duration: 10, cost: 0);

  const ConsultationOption({
    required this.duration,
    required this.cost,
  });

  final int duration; // in minutes
  final double cost;

  String get displayName {
    return switch (this) {
      ConsultationOption.physicalExamination => 'Physical Examination',
      ConsultationOption.bloodPressureCheck => 'Blood Pressure Check',
      ConsultationOption.temperatureCheck => 'Temperature Check',
      ConsultationOption.bloodTest => 'Blood Test',
      ConsultationOption.xray => 'X-Ray',
      ConsultationOption.ultrasound => 'Ultrasound',
      ConsultationOption.ecg => 'ECG',
      ConsultationOption.injection => 'Injection',
      ConsultationOption.prescription => 'Prescription',
      ConsultationOption.referral => 'Referral',
      ConsultationOption.admission => 'Hospital Admission',
      ConsultationOption.discharge => 'Discharge',
    };
  }
}
