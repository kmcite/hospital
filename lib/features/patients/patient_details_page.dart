import 'package:hospital/main.dart';
import 'package:hospital/repositories/patients_api.dart';
import 'package:hospital/repositories/balance_api.dart';
import 'package:hospital/models/receipt.dart';
import 'package:hospital/utils/navigator.dart';
import 'package:hux/hux.dart';

import '../../models/patient.dart';

class PatientDetailsPage extends UI {
  const PatientDetailsPage(this.pt, {super.key});
  final Patient pt;
  Widget build(BuildContext context) {
    return GUI(
      () {
        return Scaffold(
          appBar: AppBar(
            title: pt.name.text(),
            actions: [
              // Discharge patient button
              IconButton(
                icon: Icon(FeatherIcons.userX),
                onPressed: () {
                  patientsRepository.discharge(pt);
                  navigator.back();
                },
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
                HuxCard(
                  margin: EdgeInsets.only(bottom: 16),
                  title: 'Patient Information',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow('Name', pt.name),
                      _buildInfoRow('Patient ID', pt.id),
                      _buildInfoRow('Complaints', pt.complaints),
                      _buildInfoRow('Status',
                          pt.isManaged ? 'Under Treatment' : 'Waiting'),
                    ],
                  ),
                ),

                // Satisfaction Status Card
                HuxCard(
                  margin: EdgeInsets.only(bottom: 16),
                  title: 'Satisfaction Status',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            pt.isSatisfied()
                                ? FeatherIcons.smile
                                : FeatherIcons.frown,
                            color: pt.isSatisfied() ? Colors.green : Colors.red,
                          ),
                          SizedBox(width: 8),
                          Text(
                            pt.isSatisfied() ? 'Satisfied' : 'Unsatisfied',
                            style: TextStyle(
                              color:
                                  pt.isSatisfied() ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                          'Satisfaction Time: ${pt.satisfactionTime()} seconds'),
                      SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: pt.satisfactionProgress(),
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          pt.isSatisfied() ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),

                // Staff Assignment Card
                HuxCard(
                  margin: EdgeInsets.only(bottom: 16),
                  title: 'Staff Assignment',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStaffInfo(
                          'Manager', pt.manager?.name ?? 'Not Assigned'),
                      _buildStaffInfo('Receptionist',
                          pt.receptionist?.name ?? 'Not Assigned'),
                    ],
                  ),
                ),

                // Patient Actions Card
                HuxCard(
                  title: 'Patient Actions',
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: HuxButton(
                              onPressed: pt.isManaged
                                  ? null
                                  : () {
                                      patientsRepository.manage(pt);
                                    },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FeatherIcons.userCheck),
                                  SizedBox(width: 8),
                                  Text('Manage Patient'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: HuxButton(
                              onPressed: () {
                                patientsRepository.refer(pt);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FeatherIcons.arrowUpRight),
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
                        child: HuxButton(
                          onPressed: () {
                            _collectPatientFee(pt);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FeatherIcons.dollarSign),
                              SizedBox(width: 8),
                              Text(
                                  'Collect Fee (\$${patientFees().toStringAsFixed(0)})'),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: HuxButton(
                          onPressed: () {
                            patientsRepository.discharge(pt);
                            navigator.back();
                          },
                          variant: HuxButtonVariant.secondary,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FeatherIcons.userX),
                              SizedBox(width: 8),
                              Text('Discharge Patient'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Helper widget for information rows
Widget _buildInfoRow(String label, String value) {
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
          child: Text(value),
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

// Helper function to collect patient fee
void _collectPatientFee(Patient patient) {
  final receipt = Receipt(
    balance: patientFees(),
    metadata: {
      'type': 'Patient consultation fee - ${patient.name}',
      'patientId': patient.id,
    },
  );
  balanceRepository.useBalance(receipt);
}
