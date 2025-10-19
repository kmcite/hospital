import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:hospital/repositories/patient_repository.dart';

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

class NewPatientCubit extends Cubit<NewPatientState> {
  NewPatientCubit() : super(NewPatientState());
  late final PatientsRepository patientRepository;

  Future<void> onAgeIncremented() async {
    // emit(value..age = value.age + 1);
  }

  void onNameChanged(String name) {
    // emit(value.copyWith(name: name));
  }

  void onGenderChanged(String gender) {
    // emit(value.copyWith(gender: gender));
  }

  Future<void> onAgeDecremented() async {
    // emit(value.copyWith(age: value.age - 1));
  }

  Future<void> onSaved() async {
    // emitLoading();
    // final patient = Patient(
    //   name: value.name,
    //   age: value.age,
    //   gender: value.gender,
    // );
    // await patientRepository.put(patient);
    // emit(NewPatientState());
    // navigator.back();
  }

  void onCancel() {
    // emit(NewPatientState());
    // navigator.back();
  }
}

class NewPatientDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FDialog(
      title: Text('Add New Patient'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FTextField(
            label: Text('Full Name'),
            onChange: (value) {
              // cubit.onNameChanged(value);
            },
          ),
          FTextField(
            label: Text('Age'),
            // initialText: cubit.state.age.toString(),
            onChange: (value) {},
          ),
          Row(
            children: [
              FButton.icon(
                onPress: () {
                  // cubit.onAgeIncremented();
                },
                child: Icon(Icons.add),
              ),
              FButton.icon(
                onPress: () {
                  // cubit.onAgeDecremented();
                },
                child: Icon(Icons.minimize),
              ),
            ],
          ),
          FTextField(
            label: Text('Gender'),
            onChange: (value) {
              // cubit.onGenderChanged(value);
            },
          ),
        ],
      ),
      direction: Axis.horizontal,
      actions: [
        FButton(
          onPress: () {
            // cubit.onSaved();
          },
          child: Icon(Icons.save),
        ),
        FButton(
          onPress: () {
            // cubit.onCancel();
          },
          child: Icon(Icons.cancel),
        ),
      ],
    );
  }
}
