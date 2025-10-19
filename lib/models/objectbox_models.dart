import 'package:objectbox/objectbox.dart';

@Entity()
class Patient {
  int id;
  final String name;
  final int age;
  final String gender;
  final DateTime registrationDate;

  @Backlink('patient')
  final medicalRecords = ToMany<MedicalRecord>();

  Patient({
    this.id = 0,
    required this.name,
    required this.age,
    required this.gender,
    DateTime? registrationDate,
  }) : registrationDate = registrationDate ?? DateTime.now();
}

@Entity()
class MedicalRecord {
  int id;
  final DateTime date;
  final String doctorId;
  final String diagnosis;

  @Backlink('medicalRecord')
  final symptoms = ToMany<Symptom>();

  @Backlink('medicalRecord')
  final prescriptions = ToMany<Prescription>();

  final patient = ToOne<Patient>();

  MedicalRecord({
    this.id = 0,
    required this.doctorId,
    required this.diagnosis,
    List<String>? symptomsList,
    DateTime? date,
  }) : date = date ?? DateTime.now() {
    if (symptomsList != null) {
      symptoms.addAll(
        symptomsList.map((s) => Symptom(
              name: s,
            )..medicalRecord.target = this),
      );
    }
  }
}

@Entity()
class Prescription {
  int id;
  final String medicineName;
  final String dosage;
  final String frequency;
  final DateTime startDate;
  final DateTime endDate;
  final String? notes;

  final medicalRecord = ToOne<MedicalRecord>();

  Prescription({
    this.id = 0,
    required this.medicineName,
    required this.dosage,
    required this.frequency,
    required this.endDate,
    this.notes,
    DateTime? startDate,
  }) : startDate = startDate ?? DateTime.now();
}

@Entity()
class Symptom {
  int id;
  final String name;

  final medicalRecord = ToOne<MedicalRecord>();

  Symptom({
    this.id = 0,
    required this.name,
  });
}

@Entity()
class StaffMember {
  int id;
  final String name;
  final String role;
  final String department;
  final String contactNumber;
  final String email;
  final DateTime joinDate;
  final bool isActive;

  StaffMember({
    this.id = 0,
    required this.name,
    required this.role,
    required this.department,
    required this.contactNumber,
    required this.email,
    DateTime? joinDate,
    bool? isActive,
  })  : joinDate = joinDate ?? DateTime.now(),
        isActive = isActive ?? true;
}

// Run 'flutter pub run build_runner build' to generate the required code
// for ObjectBox to work with these models.
