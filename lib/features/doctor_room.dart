import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital/business/doctor_cubit.dart';
import 'package:hospital/features/patient_details_dialog.dart';
import 'package:hospital/utils/navigation.dart';

class DoctorRoom extends StatelessWidget {
  const DoctorRoom({super.key});

  @override
  Widget build(BuildContext context) {
    final doctorCubit = context.watch<DoctorBloc>();
    final chits = doctorCubit.state.keys;
    final consultations = doctorCubit.state.values;
    return Scaffold(
      body: ListView.builder(
        itemCount: chits.length,
        itemBuilder: (context, index) {
          final chit = chits.elementAt(index);
          final consultation = consultations.elementAt(index);
          return ListTile(
            title: Text(chit.name),
            subtitle: Text(consultation.chit.id.toString()),
            onTap: () {
              navigateToDialog(
                PatientDetailsDialog(patient: consultation),
              );
            },
          );
        },
      ),
      appBar: AppBar(
        title: const Text(
          'Doctor Room',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // leading: QuitButton(),
        actions: [
          // IconButton(
          //   onPressed: () => isGameRunning.value = !isGameRunning.value,
          //   icon: Icon(
          //     isGameRunning.value ? Icons.pause : Icons.play_arrow,
          //   ),
          // ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
