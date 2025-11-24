import 'package:flutter/material.dart';
import 'package:hospital/domain/models/patient.dart';
import 'package:hospital/utils/context.dart';
import 'package:hospital/utils/navigator.dart';
import 'package:hospital/utils/notifier.dart';
import 'package:hospital/utils/notifier_provider.dart';

class NewPatientState {
  String name = '';
  int age = 0;
  String gender = 'Male';
  NewPatientState copyWith({String? name, int? age, String? gender}) {
    return NewPatientState()
      ..name = name ?? this.name
      ..age = age ?? this.age
      ..gender = gender ?? this.gender;
  }
}

class NewPatientNotifier extends Notifier {
  NewPatientNotifier(super.context);
  late final Patients patientRepository = context.of();

  bool loading = false;
  String name = '';
  int age = 0;
  String gender = 'Male';

  Future<void> onAgeIncremented() async {
    age++;
    notifyListeners();
  }

  void onNameChanged(String name) {
    this.name = name;
    notifyListeners();
  }

  void onGenderChanged(String gender) {
    this.gender = gender;
    notifyListeners();
  }

  Future<void> onAgeDecremented() async {
    age--;
    notifyListeners();
  }

  Future<void> onSaved() async {
    loading = true;
    notifyListeners();

    patientRepository.put(
      PatientModel(
        name: name,
        age: age,
        gender: gender,
      ),
    );

    loading = false;
    notifyListeners();
    navigator.back();
  }

  void onCancel() {
    loading = false;
    notifyListeners();
    navigator.back();
  }

  void onAgeChanged(String value) {
    age = int.parse(value);
    notifyListeners();
  }
}

class NewPatientDialog extends StatelessWidget {
  const NewPatientDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return NotifierProvider(
      create: NewPatientNotifier.new,
      builder: (context, newPatient) => AlertDialog(
        title: const Text('Add New Patient'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Full Name'),
              onChanged: (value) {
                newPatient.onNameChanged(value);
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              controller: TextEditingController(
                text: newPatient.age.toString(),
              ),
              onChanged: (value) {
                newPatient.onAgeChanged(value);
              },
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    newPatient.onAgeIncremented();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.minimize),
                  onPressed: () {
                    newPatient.onAgeDecremented();
                  },
                ),
              ],
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Gender'),
              onChanged: (value) {
                newPatient.onGenderChanged(value);
              },
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              newPatient.onSaved();
            },
            child: const Icon(Icons.save),
          ),
          ElevatedButton(
            onPressed: () {
              newPatient.onCancel();
            },
            child: const Icon(Icons.cancel),
          ),
        ],
      ),
    );
  }
}
