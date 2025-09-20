import 'package:hospital/main.dart';
import 'package:hospital/repositories/balance_api.dart';
import 'package:hospital/models/receipt.dart';
import 'package:hospital/repositories/settings_api.dart';
import 'package:hux/hux.dart';

import '../../models/patient.dart';

class PatientDetailsBloc extends Bloc {
  late final BalanceRepository balanceRepository = watch();
  late final SettingsRepository settingsRepository = watch();
  double get patientFees => settingsRepository.patientFees;
  void collectPatientFee(Patient patient) {
    final receipt = Receipt(
      balance: settingsRepository.patientFees,
      metadata: {
        'type': 'Patient consultation fee - ${patient.name}',
        'patientId': patient.id.toString(),
      },
    );
    balanceRepository.put(receipt);
  }

  void discharge(Patient patient) {
    final receipt = Receipt(
      balance: settingsRepository.patientReferalFees,
      metadata: {
        'type': 'Patient referal fee - ${patient.name}',
        'patientId': patient.id.toString(),
      },
    );
    balanceRepository.put(receipt);
  }
}

class PatientDetailsPage extends Feature<PatientDetailsBloc> {
  @override
  PatientDetailsBloc create() => PatientDetailsBloc();
  const PatientDetailsPage(this.patient, {super.key});
  final Patient patient;
  Widget build(BuildContext context, controller) {
    return Scaffold(
      appBar: AppBar(
        title: patient.name.text(),
        actions: [
          // Discharge patient button
          IconButton(
            icon: Icon(FeatherIcons.userX),
            onPressed: () => controller.discharge(patient),
            tooltip: 'Discharge Patient',
          ).pad(right: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Patient Basic Information Card
            Card(
              margin: EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Patient Information',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    // _buildInfoRow('Name', patient.name),
                    // _buildInfoRow('Patient ID', patient.id),
                    // _buildInfoRow('Complaints', patient.complaints),
                    // _buildInfoRow('Status',
                    //     patient.isManaged ? 'Under Treatment' : 'Waiting'),
                  ],
                ),
              ),
            ),

            // Satisfaction Status Card
            Card(
              margin: EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Satisfaction Status',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        // Icon(
                        //   patient.isSatisfied
                        //       ? FeatherIcons.smile
                        //       : FeatherIcons.frown,
                        //   // color: patient.isSatisfied ? Colors.green : Colors.red,
                        // ),
                        SizedBox(width: 8),
                        // Text(
                        //   patient.isSatisfied ? 'Satisfied' : 'Unsatisfied',
                        //   style: TextStyle(
                        //     // color:
                        //     //     patient.isSatisfied ? Colors.green : Colors.red,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(height: 8),
                    // Text(
                    //     'Satisfaction Time: ${patient.satisfactionTime} seconds'),
                    SizedBox(height: 8),
                    LinearProgressIndicator(
                      // value: patient.satisfactionProgress,
                      backgroundColor: Colors.grey[300],
                      // valueColor: AlwaysStoppedAnimation<Color>(
                      //   patient.isSatisfied ? Colors.green : Colors.red,
                      // ),
                    ),
                  ],
                ),
              ),
            ),

            // Staff Assignment Card
            Card(
              margin: EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Staff Assignment',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    _buildStaffInfo('Manager', patient.name),
                    _buildStaffInfo('Receptionist', patient.name),
                  ],
                ),
              ),
            ),

            // Patient Actions Card
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Patient Actions',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed:
                                // patient.isManaged
                                //     ? null
                                //     :
                                () {
                              // patientsRepository.manage(patient);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person_add),
                                SizedBox(width: 8),
                                Text('Manage Patient'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // patientsRepository.refer(patient);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_outward),
                                SizedBox(width: 8),
                                Text('Refer Patient'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.collectPatientFee(patient);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.attach_money),
                            SizedBox(width: 8),
                            Text(
                                'Collect Fee (\$${controller.patientFees.toStringAsFixed(0)})'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          controller.discharge(patient);
                          navigator.back();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person_remove),
                            SizedBox(width: 8),
                            Text('Discharge Patient'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper widget for information rows
// ignore: unused_element
Widget _buildInfoRow(String label, int value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            '$label:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(value.toString()),
        ),
      ],
    ),
  );
}

// Helper widget for staff information
Widget _buildStaffInfo(String role, String name) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(
          role == 'Manager' ? FeatherIcons.user : FeatherIcons.users,
          size: 16,
        ),
        SizedBox(width: 8),
        Text(
          '$role: ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(name),
      ],
    ),
  );
}
