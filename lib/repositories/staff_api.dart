import 'package:hospital/main.dart';
import 'package:hospital/models/staff/staff.dart';
import 'package:objectbox/objectbox.dart';

import '../models/staff/doctor.dart';
import '../models/staff/nurse.dart';
import '../models/staff/receptionist.dart';

class StaffRepository extends Repository {
  bool isGenerating = false;

  Store get store => find();
  Box<Staff> get box => store.box<Staff>();

  // Current active staff
  Receptionist? currentReceptionist;
  Doctor? currentDoctor;
  Nurse? currentNurse;

  StaffRepository() {
    // Start with some initial staff generation
    _generateInitialStaff();
  }

  // Create operations
  Doctor createDoctor({
    String? name,
    String? specialization,
    double? salary,
    int? yearsOfExperience,
    double? consultationFee,
  }) {
    final doctor = name != null
        ? Doctor.create(
            name: name,
            specialization: specialization ?? 'General Medicine',
            salary: salary ?? 80000,
            yearsOfExperience: yearsOfExperience ?? 5,
            consultationFee: consultationFee ?? 200,
          )
        : Doctor();

    final id = box.put(doctor);
    doctor.id = id;
    notifyListeners('Doctor hired: ${doctor.name}');
    return doctor;
  }

  Nurse createNurse({
    String? name,
    double? salary,
    String? shiftType,
    int? wardAssignment,
    bool? isHeadNurse,
  }) {
    final nurse = name != null
        ? Nurse.create(
            name: name,
            salary: salary ?? 50000,
            shiftType: shiftType ?? 'day',
            wardAssignment: wardAssignment ?? 1,
            isHeadNurse: isHeadNurse ?? false,
          )
        : Nurse();

    final id = box.put(nurse);
    nurse.id = id;
    notifyListeners('Nurse hired: ${nurse.name}');
    return nurse;
  }

  Receptionist createReceptionist({
    String? name,
    double? salary,
    bool? canHandleInsurance,
    List<String>? languages,
  }) {
    final receptionist = name != null
        ? Receptionist.create(
            name: name,
            salary: salary ?? 35000,
            canHandleInsurance: canHandleInsurance ?? false,
            languages: languages,
          )
        : Receptionist();

    final id = box.put(receptionist);
    receptionist.id = id;
    notifyListeners('Receptionist hired: ${receptionist.name}');
    return receptionist;
  }

  // Read operations
  Staff? getById(int id) => box.get(id);

  Iterable<Staff> getAll() => box.getAll();

  Iterable<Doctor> get doctors => box.getAll().whereType<Doctor>();

  Iterable<Nurse> get nurses => box.getAll().whereType<Nurse>();

  Iterable<Receptionist> get receptionists =>
      box.getAll().whereType<Receptionist>();

  // Filter operations
  Iterable<Staff> getAvailableStaff() {
    return getAll().where((staff) => staff.isAvailable);
  }

  Iterable<Staff> getWorkingStaff() {
    return getAll().where((staff) => staff.isWorking);
  }

  Iterable<Staff> getHiredStaff() {
    return getAll().where((staff) => staff.isHired);
  }

  Iterable<Doctor> getAvailableDoctors() {
    return doctors.where((doctor) => doctor.canConsult);
  }

  Iterable<Nurse> getAvailableNurses() {
    return nurses.where((nurse) => nurse.canProviderCare);
  }

  Iterable<Receptionist> getAvailableReceptionists() {
    return receptionists
        .where((receptionist) => receptionist.canProcessPatients);
  }

  // Search operations
  Iterable<Staff> searchByName(String name) {
    return getAll().where(
        (staff) => staff.name.toLowerCase().contains(name.toLowerCase()));
  }

  Iterable<Staff> getByDepartment(String department) {
    return getAll().where(
        (staff) => staff.department.toLowerCase() == department.toLowerCase());
  }

  Iterable<Doctor> getDoctorsBySpecialization(String specialization) {
    return doctors.where((doctor) => doctor.specializations.any(
        (spec) => spec.toLowerCase().contains(specialization.toLowerCase())));
  }

  // Update operations
  void updateStaff(Staff staff) {
    box.put(staff);
    notifyListeners('Staff updated: ${staff.name}');
  }

  void put(Staff staff) => updateStaff(staff);

  // Employment management
  void hireStaff(Staff staff) {
    staff.hire();
    updateStaff(staff);
    notifyListeners('Staff hired: ${staff.name}');
  }

  void fireStaff(Staff staff) {
    staff.fire();

    // Remove from current assignments if applicable
    if (staff == currentDoctor) currentDoctor = null;
    if (staff == currentNurse) currentNurse = null;
    if (staff == currentReceptionist) currentReceptionist = null;

    updateStaff(staff);
    notifyListeners('Staff fired: ${staff.name}');
  }

  // Duty assignment
  void setCurrentReceptionist(Receptionist? receptionist) {
    if (currentReceptionist != null) {
      currentReceptionist!.goOffDuty();
      updateStaff(currentReceptionist!);
    }

    currentReceptionist = receptionist;

    if (receptionist != null) {
      receptionist.goOnDuty();
      updateStaff(receptionist);
    }

    notifyListeners('Current receptionist changed');
  }

  void setCurrentDoctor(Doctor? doctor) {
    if (currentDoctor != null) {
      currentDoctor!.goOffDuty();
      updateStaff(currentDoctor!);
    }

    currentDoctor = doctor;

    if (doctor != null) {
      doctor.goOnDuty();
      updateStaff(doctor);
    }

    notifyListeners('Current doctor changed');
  }

  void setCurrentNurse(Nurse? nurse) {
    if (currentNurse != null) {
      currentNurse!.goOffDuty();
      updateStaff(currentNurse!);
    }

    currentNurse = nurse;

    if (nurse != null) {
      nurse.goOnDuty();
      updateStaff(nurse);
    }

    notifyListeners('Current nurse changed');
  }

  // Work management
  void startWork(Staff staff, int durationMinutes) {
    try {
      staff.startWork(durationMinutes);
      updateStaff(staff);
      notifyListeners('${staff.name} started work');
    } catch (e) {
      notifyListeners('Failed to start work for ${staff.name}: $e');
    }
  }

  void completeWork(Staff staff) {
    try {
      staff.completeWork();
      updateStaff(staff);
      notifyListeners('${staff.name} completed work');
    } catch (e) {
      notifyListeners('Failed to complete work for ${staff.name}: $e');
    }
  }

  void takeBreak(Staff staff) {
    try {
      staff.takeBreak();
      updateStaff(staff);
      notifyListeners('${staff.name} is on break');
    } catch (e) {
      notifyListeners('Failed to start break for ${staff.name}: $e');
    }
  }

  void restStaff(Staff staff) {
    staff.rest();
    updateStaff(staff);
    notifyListeners('${staff.name} is resting');
  }

  // Staff generation
  void _generateInitialStaff() {
    // Create some initial staff if none exist
    if (getAll().isEmpty) {
      createDoctor();
      createNurse();
      createReceptionist();
    }
  }

  void generateStaff() {
    final doctor = createDoctor();
    final nurse = createNurse();
    final receptionist = createReceptionist();

    notifyListeners(
      'Generated ${doctor.name}, ${nurse.name}, ${receptionist.name}',
    );
  }

  void toggleGeneration() {
    isGenerating = !isGenerating;
    if (isGenerating) {
      _startAutomaticGeneration();
    }
    notifyListeners(
        'Staff generation ${isGenerating ? "enabled" : "disabled"}');
  }

  void _startAutomaticGeneration() async {
    while (isGenerating) {
      final durationForNextIteration =
          faker.randomGenerator.integer(30, min: 10);
      await Future.delayed(Duration(seconds: durationForNextIteration));

      if (isGenerating && getAll().length < 20) {
        // Limit total staff
        generateStaff();
      }
    }
  }

  // Delete operations
  bool deleteStaff(int staffId) {
    final staff = getById(staffId);
    if (staff != null) {
      // Remove from current assignments
      if (staff == currentDoctor) currentDoctor = null;
      if (staff == currentNurse) currentNurse = null;
      if (staff == currentReceptionist) currentReceptionist = null;
    }

    final success = box.remove(staffId);
    if (success) {
      notifyListeners('Staff deleted');
    }
    return success;
  }

  void deleteAll() {
    currentDoctor = null;
    currentNurse = null;
    currentReceptionist = null;
    box.removeAll();
    notifyListeners('All staff deleted');
  }

  // Analytics
  int getTotalStaffCount() => box.count();

  int getDoctorsCount() => doctors.length;

  int getNursesCount() => nurses.length;

  int getReceptionistsCount() => receptionists.length;

  Map<String, int> getStaffTypeStatistics() {
    return {
      'Doctors': getDoctorsCount(),
      'Nurses': getNursesCount(),
      'Receptionists': getReceptionistsCount(),
    };
  }

  Map<WorkState, int> getWorkStateStatistics() {
    final stats = <WorkState, int>{};
    for (final state in WorkState.values) {
      stats[state] = getAll().where((staff) => staff.workState == state).length;
    }
    return stats;
  }

  double getAveragePerformanceRating() {
    final staff = getAll();
    if (staff.isEmpty) return 0.0;

    final totalRating = staff.fold<double>(
        0.0, (sum, member) => sum + member.performanceRating);
    return totalRating / staff.length;
  }

  double getTotalSalaryExpense() {
    return getHiredStaff()
        .fold<double>(0.0, (sum, staff) => sum + staff.salary);
  }
}
