import 'package:objectbox/objectbox.dart';
import 'package:hospital/main.dart';
import 'staff/staff.dart';
import 'consultation.dart';
import 'patient.dart';

@Entity()
class Reception {
  @Id()
  int mr = 0; // Medical Record number

  // Reception details
  String receptionId = '';
  String purpose = ''; // consultation, emergency, follow-up, etc.
  String notes = '';

  // Timing
  @Property(type: PropertyType.date)
  DateTime arrivalTime = DateTime.now();
  @Property(type: PropertyType.date)
  DateTime? processingStartTime;
  @Property(type: PropertyType.date)
  DateTime? processingEndTime;
  @Property(type: PropertyType.date)
  DateTime? appointmentTime;

  // Status tracking
  int statusIndex = 0;
  @Transient()
  ReceptionStatus get status => ReceptionStatus.values[statusIndex];
  set status(ReceptionStatus value) {
    statusIndex = value.index;
  }

  // Financial
  double registrationFee = 50.0;
  double consultationFee = 200.0;
  double totalFees = 0.0;
  bool isPaid = false;

  // Priority and urgency
  int priorityIndex = 1; // Default to normal
  @Transient()
  ReceptionPriority get priority => ReceptionPriority.values[priorityIndex];
  set priority(ReceptionPriority value) {
    priorityIndex = value.index;
  }

  // Insurance and documentation
  bool hasInsurance = false;
  String insuranceProvider = '';
  String documentationStatus = 'pending'; // pending, complete, incomplete

  // Relationships
  final patient = ToOne<Patient>();
  final receptionist = ToOne<Staff>();
  final assignedDoctor = ToOne<Staff>();
  final assignedNurse = ToOne<Staff>();
  final consultation = ToOne<Consultation>();

  Reception() {
    receptionId = 'REC${faker.randomGenerator.integer(99999, min: 10000)}';
    status = ReceptionStatus.arrived;
    priority = ReceptionPriority.normal;
    _calculateFees();
  }

  Reception.create({
    required Patient patient,
    required Staff receptionist,
    this.purpose = 'consultation',
    ReceptionPriority priority = ReceptionPriority.normal,
    this.hasInsurance = false,
    this.insuranceProvider = '',
  }) {
    this.patient.target = patient;
    this.receptionist.target = receptionist;
    this.priority = priority;
    this.receptionId = 'REC${faker.randomGenerator.integer(99999, min: 10000)}';
    this.status = ReceptionStatus.arrived;
    _calculateFees();
  }

  void _calculateFees() {
    totalFees = registrationFee + consultationFee;

    // Apply insurance discount if applicable
    if (hasInsurance) {
      totalFees *= 0.8; // 20% discount for insured patients
    }

    // Adjust fees based on priority
    switch (priority) {
      case ReceptionPriority.emergency:
        totalFees += 100; // Emergency surcharge
        break;
      case ReceptionPriority.urgent:
        totalFees += 50; // Urgent surcharge
        break;
      default:
        break;
    }
  }

  // Business methods
  void startProcessing() {
    if (status != ReceptionStatus.arrived) {
      throw StateError('Patient must have arrived to start processing');
    }
    status = ReceptionStatus.beingProcessed;
    processingStartTime = DateTime.now();
  }

  void completeProcessing() {
    if (status != ReceptionStatus.beingProcessed) {
      throw StateError('Processing must be in progress to complete');
    }
    status = ReceptionStatus.waitingForDoctor;
    processingEndTime = DateTime.now();
    documentationStatus = 'complete';
  }

  void assignDoctor(Staff doctor) {
    assignedDoctor.target = doctor;

    // Update consultation fee based on doctor's rate
    // Note: Need proper type checking for Doctor class
    // if (doctor is Doctor) {
    //   consultationFee = doctor.consultationFee;
    //   _calculateFees();
    // }
  }

  void assignNurse(Staff nurse) {
    assignedNurse.target = nurse;
  }

  void scheduleAppointment(DateTime appointmentTime) {
    this.appointmentTime = appointmentTime;
    status = ReceptionStatus.scheduled;
  }

  void startConsultation(Consultation consultation) {
    this.consultation.target = consultation;
    status = ReceptionStatus.inConsultation;
  }

  void completeConsultation() {
    if (status != ReceptionStatus.inConsultation) {
      throw StateError('Must be in consultation to complete');
    }
    status = ReceptionStatus.consultationComplete;
  }

  void processPayment() {
    isPaid = true;
    status = ReceptionStatus.paymentComplete;
  }

  void discharge() {
    if (!isPaid) {
      throw StateError('Payment must be completed before discharge');
    }
    status = ReceptionStatus.discharged;
  }

  void cancel(String reason) {
    status = ReceptionStatus.cancelled;
    notes = 'Cancelled: $reason';
  }

  void updateInsuranceInfo(String provider) {
    hasInsurance = true;
    insuranceProvider = provider;
    _calculateFees(); // Recalculate with insurance discount
  }

  void removeInsurance() {
    hasInsurance = false;
    insuranceProvider = '';
    _calculateFees(); // Recalculate without insurance discount
  }

  // Computed properties
  @Transient()
  Duration? get processingDuration {
    if (processingStartTime == null || processingEndTime == null) return null;
    return processingEndTime!.difference(processingStartTime!);
  }

  @Transient()
  Duration get waitingTime {
    DateTime endTime = processingStartTime ?? DateTime.now();
    return endTime.difference(arrivalTime);
  }

  @Transient()
  Duration? get timeUntilAppointment {
    if (appointmentTime == null) return null;
    final now = DateTime.now();
    if (appointmentTime!.isBefore(now)) return null;
    return appointmentTime!.difference(now);
  }

  @Transient()
  bool get isConsulted => consultation.target != null;

  @Transient()
  bool get isScheduled => status == ReceptionStatus.scheduled;

  @Transient()
  bool get isWaitingForDoctor => status == ReceptionStatus.waitingForDoctor;

  @Transient()
  bool get isInConsultation => status == ReceptionStatus.inConsultation;

  @Transient()
  bool get isCompleted => status == ReceptionStatus.discharged;

  @Transient()
  bool get isCancelled => status == ReceptionStatus.cancelled;

  @Transient()
  bool get needsPayment => !isPaid && totalFees > 0;

  @Transient()
  bool get hasValidInsurance => hasInsurance && insuranceProvider.isNotEmpty;

  @Transient()
  String get statusDescription {
    return switch (status) {
      ReceptionStatus.arrived => 'Patient Arrived',
      ReceptionStatus.beingProcessed => 'Being Processed',
      ReceptionStatus.waitingForDoctor => 'Waiting for Doctor',
      ReceptionStatus.scheduled => 'Appointment Scheduled',
      ReceptionStatus.inConsultation => 'In Consultation',
      ReceptionStatus.consultationComplete => 'Consultation Complete',
      ReceptionStatus.paymentComplete => 'Payment Complete',
      ReceptionStatus.discharged => 'Discharged',
      ReceptionStatus.cancelled => 'Cancelled',
    };
  }

  @Transient()
  String get priorityDescription {
    return switch (priority) {
      ReceptionPriority.low => 'Low Priority',
      ReceptionPriority.normal => 'Normal',
      ReceptionPriority.high => 'High Priority',
      ReceptionPriority.urgent => 'Urgent',
      ReceptionPriority.emergency => 'Emergency',
    };
  }

  // Backward compatibility
  @Transient()
  double get fees => totalFees;

  @override
  String toString() {
    return 'Reception $receptionId (MR: $mr) - ${patient.target?.name ?? "Unknown Patient"} '
        '- $statusDescription ($priorityDescription)';
  }
}

enum ReceptionStatus {
  arrived,
  beingProcessed,
  waitingForDoctor,
  scheduled,
  inConsultation,
  consultationComplete,
  paymentComplete,
  discharged,
  cancelled,
}

enum ReceptionPriority {
  low,
  normal,
  high,
  urgent,
  emergency,
}
