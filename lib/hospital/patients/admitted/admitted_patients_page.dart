import 'package:hospital/hospital/navigator/app_scaffold.dart';
import 'package:hospital/hospital/patients/admitted/admitted_patients_bloc.dart';
import 'package:hospital/main.dart';

class AdmittedPatientsPage extends UI {
  const AdmittedPatientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(),
      body: admittedPatientsBloc.admittedPatients.isEmpty
          ? Center(child: Text('No patients admitted.'))
          : ListView.builder(
              itemCount: admittedPatientsBloc.admittedPatients.length,
              itemBuilder: (context, index) {
                final patient = admittedPatientsBloc.admittedPatients[index];
                final progress =
                    1 - (patient.remainingTime / patient.admissionTime);
                return ListTile(
                  leading: const Icon(Icons.bed),
                  title: Text('Symptom: ${patient.symptom}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Remaining Time: ${patient.remainingTime}s'),
                      Text(
                          'Satisfaction: ${patient.satisfaction.toStringAsFixed(1)}%'),
                      Text(
                          'Investigations: ${patient.investigations.join(', ')}')
                    ],
                  ),
                  trailing: patient.remainingTime <= 0
                      ? ElevatedButton(
                          onPressed: () {
                            admittedPatientsBloc.dischargePatient(patient);
                          },
                          child: const Text('Discharge'),
                        )
                      : SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 4,
                          ),
                        ),
                );
              },
            ),
    );
  }
}
