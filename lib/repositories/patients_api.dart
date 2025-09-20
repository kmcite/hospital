import 'package:hospital/main.dart';
import 'package:objectbox/objectbox.dart';
import 'dart:math';
import '../models/patient.dart';

class PatientsRepository extends Repository {
  final store = find<Store>();
  late final box = store.box<Patient>();

  // Patient generation for simulation
  void generateRandomPatient() {
    final random = Random();
    final names = [
      'John Smith',
      'Emily Johnson',
      'Michael Brown',
      'Sarah Davis',
      'David Wilson',
      'Jessica Miller',
      'Robert Taylor',
      'Lisa Anderson',
      'William Thomas',
      'Jennifer Jackson',
      'James White',
      'Maria Harris',
      'Charles Martin',
      'Laura Thompson',
      'Christopher Garcia',
      'Michelle Martinez'
    ];

    final complaints = [
      'Chest pain and difficulty breathing',
      'Severe headache and dizziness',
      'Abdominal pain and nausea',
      'High fever and body aches',
      'Back pain and muscle stiffness',
      'Allergic reaction and skin rash',
      'Broken bone after accident',
      'Eye infection and vision problems',
      'Throat infection and swallowing difficulty',
      'Heart palpitations and anxiety'
    ];

    final name = names[random.nextInt(names.length)];
    final complaint = complaints[random.nextInt(complaints.length)];
    final urgency =
        UrgencyLevel.values[random.nextInt(UrgencyLevel.values.length)];
    final isInsured = random.nextBool();

    createPatient(
      name: name,
      complaints: complaint,
      urgency: urgency,
      isInsured: isInsured,
    );
  }

  Patient createPatient({
    required String name,
    required String complaints,
    UrgencyLevel urgency = UrgencyLevel.low,
    bool isInsured = false,
  }) {
    final patient = Patient.create(
      name: name,
      complaints: complaints,
      urgency: urgency,
      isInsured: isInsured,
    );

    final id = box.put(patient);
    patient.id = id;
    notifyListeners('Patient created: ${patient.name}');
    return patient;
  }

  // Read operations
  Patient? getById(int id) {
    return box.get(id);
  }

  Iterable<Patient> getAll() => box.getAll();

  Iterable<Patient> getByStatus(PatientStatus status) {
    return getAll().where((patient) => patient.status == status);
  }

  Iterable<Patient> getByUrgency(UrgencyLevel urgency) {
    return getAll().where((patient) => patient.urgency == urgency);
  }

  Iterable<Patient> getWaitingPatients() {
    return getByStatus(PatientStatus.waiting);
  }

  Iterable<Patient> getAdmittedPatients() {
    return getByStatus(PatientStatus.admitted);
  }

  Iterable<Patient> getPatientsUnderTreatment() {
    return getByStatus(PatientStatus.underTreatment);
  }

  Iterable<Patient> getReadyForDischarge() {
    return getByStatus(PatientStatus.readyForDischarge);
  }

  Iterable<Patient> getDischargedPatients() {
    return getByStatus(PatientStatus.discharged);
  }

  Iterable<Patient> getReferredPatients() {
    return getByStatus(PatientStatus.referred);
  }

  // Search operations
  Iterable<Patient> searchByName(String name) {
    return getAll().where(
        (patient) => patient.name.toLowerCase().contains(name.toLowerCase()));
  }

  Iterable<Patient> searchByComplaints(String complaints) {
    return getAll().where((patient) =>
        patient.complaints.toLowerCase().contains(complaints.toLowerCase()));
  }

  // Update operations
  void updatePatient(Patient patient) {
    patient.updatedAt = DateTime.now();
    box.put(patient);
    notifyListeners('Patient updated: ${patient.name}');
  }

  // Status transition methods
  void admitPatient(Patient patient) {
    try {
      patient.admit();
      updatePatient(patient);
      notifyListeners('Patient admitted: ${patient.name}');
    } catch (e) {
      notifyListeners('Failed to admit patient: $e');
      rethrow;
    }
  }

  void startTreatment(Patient patient) {
    try {
      patient.startTreatment();
      updatePatient(patient);
      notifyListeners('Treatment started for: ${patient.name}');
    } catch (e) {
      notifyListeners('Failed to start treatment: $e');
      rethrow;
    }
  }

  void markReadyForDischarge(Patient patient) {
    try {
      patient.readyForDischarge();
      updatePatient(patient);
      notifyListeners('Patient ready for discharge: ${patient.name}');
    } catch (e) {
      notifyListeners('Failed to mark ready for discharge: $e');
      rethrow;
    }
  }

  void dischargePatient(Patient patient) {
    try {
      patient.discharge();
      updatePatient(patient);
      notifyListeners('Patient discharged: ${patient.name}');
    } catch (e) {
      notifyListeners('Failed to discharge patient: $e');
      rethrow;
    }
  }

  void referPatient(Patient patient, String reason) {
    try {
      patient.refer(reason);
      updatePatient(patient);
      notifyListeners('Patient referred: ${patient.name}');
    } catch (e) {
      notifyListeners('Failed to refer patient: $e');
      rethrow;
    }
  }

  // Payment operations
  void processPayment(Patient patient, double amount) {
    patient.addPayment(amount);
    updatePatient(patient);
    notifyListeners('Payment processed for: ${patient.name}');
  }

  // Satisfaction management
  void updateSatisfaction(Patient patient, double score) {
    patient.updateSatisfaction(score);
    updatePatient(patient);
    notifyListeners('Satisfaction updated for: ${patient.name}');
  }

  // Staff assignment
  void assignDoctor(Patient patient, dynamic doctor) {
    patient.assignDoctor(doctor);
    updatePatient(patient);
    notifyListeners('Doctor assigned to: ${patient.name}');
  }

  void assignNurse(Patient patient, dynamic nurse) {
    patient.assignNurse(nurse);
    updatePatient(patient);
    notifyListeners('Nurse assigned to: ${patient.name}');
  }

  // Delete operations
  bool deletePatient(int patientId) {
    final success = box.remove(patientId);
    if (success) {
      notifyListeners('Patient deleted');
    }
    return success;
  }

  void deleteAll() {
    box.removeAll();
    notifyListeners('All patients deleted');
  }

  // Analytics and statistics
  int getTotalPatientsCount() => box.count();

  int getCountByStatus(PatientStatus status) {
    return getByStatus(status).length;
  }

  Map<PatientStatus, int> getStatusStatistics() {
    final stats = <PatientStatus, int>{};
    for (final status in PatientStatus.values) {
      stats[status] = getCountByStatus(status);
    }
    return stats;
  }

  Map<UrgencyLevel, int> getUrgencyStatistics() {
    final stats = <UrgencyLevel, int>{};
    for (final urgency in UrgencyLevel.values) {
      final count = getByUrgency(urgency).length;
      stats[urgency] = count;
    }
    return stats;
  }

  double getAverageSatisfactionScore() {
    final patients = getAll();
    if (patients.isEmpty) return 0.0;

    final totalScore = patients.fold<double>(
        0.0, (sum, patient) => sum + patient.satisfactionScore);
    return totalScore / patients.length;
  }

  Duration getAverageWaitingTime() {
    final waitingPatients = getWaitingPatients();
    if (waitingPatients.isEmpty) return Duration.zero;

    final totalMinutes = waitingPatients.fold<int>(
        0, (sum, patient) => sum + patient.waitingTime.inMinutes);
    return Duration(minutes: totalMinutes ~/ waitingPatients.length);
  }

  // Backward compatibility methods
  void manage(Patient patient) => startTreatment(patient);
  void wait(Patient patient) {
    patient.status = PatientStatus.waiting;
    updatePatient(patient);
  }

  void refer(Patient patient) => referPatient(patient, 'General referral');
  void discharge(Patient patient) => dischargePatient(patient);

  Iterable<Patient> get referred => getReferredPatients();
  Iterable<Patient> get waiting => getWaitingPatients();
  Iterable<Patient> get managed => getPatientsUnderTreatment();
  Iterable<Patient> get discharged => getDischargedPatients();
}
