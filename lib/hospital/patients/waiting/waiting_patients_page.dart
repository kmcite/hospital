import 'package:hospital/hospital/navigator/navigator.dart';
import 'package:hospital/hospital/patients/admitted/admitted_patients_repository.dart';
import 'package:hospital/hospital/patients/patient.dart';
import 'package:hospital/hospital/patients/waiting/waiting_patients_bloc.dart';
import 'package:hospital/main.dart';
import 'package:hospital/hospital/navigator/app_scaffold.dart';
import 'package:icons_plus/icons_plus.dart';

class WaitingPatientsPage extends UI {
  WaitingPatientsBloc get waitingPatientsBloc => waitingPatientsBlocRM.state;

  const WaitingPatientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: waitingPatientsBloc.waitingPatients.isEmpty
          ? Center(
              child: Text('no patients are waiting'),
            )
          : PatientGridPage(patients: waitingPatientsBloc.waitingPatients),
      // GridView.builder(
      //     itemCount: waitingPatientsBloc.waitingPatients.length,
      //     physics: BouncingScrollPhysics(),
      //     gridDelegate:
      //         SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      //     itemBuilder: (context, index) {
      //       final patient =
      //           waitingPatientsBloc.waitingPatients.elementAt(index);
      //       return GridTile(
      //         child: Stack(
      //           children: [
      //             Material(
      //               color: !patient.canPay
      //                   ? Colors.blue
      //                   : patient.isEmergency
      //                       ? Colors.red
      //                       : Colors.green,
      //               elevation: 4,
      //               type: MaterialType.card,
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.stretch,
      //                 children: [
      //                   patient.symptom.text().pad(),
      //                   // patient.text().pad(),
      //                 ],
      //               ),
      //             ).pad(),
      //             patient.isEmergency
      //                 ? const Icon(Icons.warning, color: Colors.green)
      //                 : const Icon(Icons.info, color: Colors.red),
      //             Align(
      //               alignment: Alignment.bottomRight,
      //               child: Row(
      //                 children: [

      //                 ],
      //               ),
      //             )
      //           ],
      //         ),
      //       );
      //     },
      //   ),
    );
  }
}

class PatientDetailsPage extends StatelessWidget {
  final Patient patient;

  const PatientDetailsPage({
    Key? key,
    required this.patient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Symptom
            Text(
              'Symptom: ${patient.symptom}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Admission and Emergency Status
            Text('Admission Time: ${patient.admissionTime} min'),
            const SizedBox(height: 4),
            Text('Remaining Time: ${patient.remainingTime} min'),
            const SizedBox(height: 4),
            Text('Emergency: ${patient.isEmergency ? "Yes" : "No"}'),
            const SizedBox(height: 4),

            // Payment Ability
            Text('Can Pay: ${patient.canPay ? "Yes" : "No"}'),
            const SizedBox(height: 4),

            // Satisfaction
            Text('Satisfaction: ${patient.satisfaction.toStringAsFixed(1)}%'),
            const SizedBox(height: 16),

            // Investigations
            const Text(
              'Investigations:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (patient.investigations.isNotEmpty)
              ...patient.investigations
                  .map((investigation) => Text('- $investigation'))
                  .toList()
            else
              const Text('No investigations assigned.'),
            FilledButton(
              onPressed: availableBedsRM.state.beds > 0
                  ? () => waitingPatientsBloc.admitPatient(patient)
                  : null,
              child: 'admit'.text(),
            ),
            FilledButton(
              onPressed: () => waitingPatientsBloc.refer(patient),
              child: 'refer'.text(),
            ),
            if (patient.canPay) Icon(FontAwesome.face_frown_open)
          ],
        ),
      ),
    );
  }
}

class PatientTile extends StatelessWidget {
  final Patient patient;
  final VoidCallback onTap;

  const PatientTile({
    Key? key,
    required this.patient,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: patient.isEmergency ? Colors.red : Colors.blue,
          child: Icon(
            patient.isEmergency ? Icons.warning : Icons.person,
            color: Colors.white,
          ),
        ),
        title: Text(patient.symptom),
        subtitle: Text(
          'Admission Time: ${patient.admissionTime} min | Satisfaction: ${patient.satisfaction.toStringAsFixed(1)}%',
        ),
        trailing: patient.canPay
            ? const Icon(Icons.payment, color: Colors.green)
            : const Icon(Icons.money_off, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}

class PatientGridPage extends StatelessWidget {
  final List<Patient> patients;

  const PatientGridPage({
    Key? key,
    required this.patients,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients Grid'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of tiles per row
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 3 / 4, // Adjust for tile aspect ratio
        ),
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients[index];
          return PatientGridTile(
            patient: patient,
            onTap: () => navigator.to(PatientDetailsPage(patient: patient)),
          );
        },
      ),
    );
  }
}

class PatientGridTile extends StatelessWidget {
  final Patient patient;
  final VoidCallback onTap;

  const PatientGridTile({
    Key? key,
    required this.patient,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(8),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Emergency indicator
            CircleAvatar(
              radius: 30,
              backgroundColor: patient.isEmergency ? Colors.red : Colors.blue,
              child: Icon(
                patient.isEmergency ? Icons.warning : Icons.person,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(height: 8),

            // Patient Symptom
            Text(
              patient.symptom,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),

            // Admission Time and Satisfaction
            Text(
              'Admission: ${patient.admissionTime} min',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              'Satisfaction: ${patient.satisfaction.toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 14, color: Colors.green),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.download_done,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.cancel_outlined,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
