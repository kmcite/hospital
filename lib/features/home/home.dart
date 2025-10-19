import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital/features/home/new_patient.dart';
import 'package:hospital/navigator.dart';
import 'package:hospital/repositories/patient_repository.dart';
import 'package:hospital/models/objectbox_models.dart';

class HomeState {
  List<Patient> patients = [];
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this.patientRepository,
  ) : super(HomeState());
  final PatientsRepository patientRepository;

  Future<void> refresh() async {
    emit(HomeState()..patients = await patientRepository.getAll());
  }

  Future<void> addPatient(Patient patient) async {
    try {
      await patientRepository.put(patient);
      emit(HomeState()..patients = await patientRepository.getAll());
    } catch (e) {}
  }
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        context.read(),
      ),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('Hospital Management'),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => context.read<HomeCubit>().refresh(),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: _HomeBody(cubit: context.read<HomeCubit>()),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigator.toDialog(NewPatientDialog());
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  final HomeCubit cubit;

  const _HomeBody({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return _PatientListView(patients: cubit.state.patients);
  }
}

class _PatientListView extends StatelessWidget {
  final List<Patient> patients;

  const _PatientListView({required this.patients});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: patients.length,
      itemBuilder: (context, index) {
        final patient = patients[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(patient.name),
            subtitle: Text('Age: ${patient.age} | Gender: ${patient.gender}'),
            trailing: Text('Records: ${patient.medicalRecords.length}'),
            onTap: () {
              // Navigate to patient details
            },
          ),
        );
      },
    );
  }
}
