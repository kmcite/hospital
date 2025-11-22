import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
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
      builder: (context, newPatient) => FDialog(
        title: Text('Add New Patient'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            FTextField(
              label: Text('Full Name'),
              onChange: (value) {
                newPatient.onNameChanged(value);
              },
            ),
            FTextField(
              label: Text('Age'),
              initialText: newPatient.age.toString(),
              onChange: (value) {
                newPatient.onAgeChanged(value);
              },
            ),
            Row(
              children: [
                FButton.icon(
                  onPress: () {
                    newPatient.onAgeIncremented();
                  },
                  child: Icon(Icons.add),
                ),
                FButton.icon(
                  onPress: () {
                    newPatient.onAgeDecremented();
                  },
                  child: Icon(Icons.minimize),
                ),
              ],
            ),
            FTextField(
              label: Text('Gender'),
              onChange: (value) {
                newPatient.onGenderChanged(value);
              },
            ),
          ],
        ),
        direction: Axis.horizontal,
        actions: [
          FButton(
            onPress: () {
              newPatient.onSaved();
            },
            child: Icon(Icons.save),
          ),
          FButton(
            onPress: () {
              newPatient.onCancel();
            },
            child: Icon(Icons.cancel),
          ),
        ],
      ),
    );
  }
}
