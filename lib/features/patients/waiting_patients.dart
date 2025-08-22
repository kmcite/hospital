import 'package:hospital/main.dart';
import 'package:hospital/repositories/receptions_api.dart';
import 'package:hospital/utils/list_view.dart';
import 'package:hux/hux.dart';

import '../../repositories/balance_api.dart';
import '../../models/patient.dart';
import '../../repositories/patients_api.dart';
import '../../models/receipt.dart';

void manage(Patient patient) {}

Widget waitingPatientsList() => GUI(
      () {
        return listView(
          receptionsRepository.receptions.values,
          (patient) {
            return HuxCard(
              margin: EdgeInsetsGeometry.all(8),
              title: patient.patient.name,
              subtitle: patient.patient.complaints,
              child: Row(
                spacing: 8,
                children: [
                  HuxButton(
                    onPressed: () {},
                    child: Icon(FeatherIcons.activity),
                  ),
                  HuxButton(
                    onPressed: () {
                      // referPatientElsewhere(patient);
                    },
                    child: Icon(FeatherIcons.arrowUpRight),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

// /// Revert a receipt (negate amount)
// void useBalance(Receipt r) {
//   final balance = r.balance;
//   final updated = r..balance = -balance;
//   receipts[updated.id] = updated;
// }

/// Manage patient by any doctor
/// manage patient by a staff
// void managePatient(Patient patient, Staff staff) {
//   batch(() {
//     /// remove from waiting list
//     patientsRepository.waitingPatients.remove(patient.id);

//     /// add to managed list
//     patientsRepository.managedPatients[patient.id] = patient..manager = staff;

//     /// get fees
//     balanceRepository.unuseBalance(
//       Receipt()
//         ..balance = patientFees()
//         ..details = '${patient.name} FEES',
//     );
//   });
// }

void referPatientElsewhere(Patient patient) {
  batch(
    () {
      /// remove from waiting list
      // patientsRepository.waitingPatients.remove(patient.id);

      // /// add to referred list
      // patientsRepository.referredPatients[patient.id] = patient;

      /// penalty for referral
      balanceRepository.useBalance(
        Receipt(
          balance: patientReferalFees(),
          metadata: {
            'type': 'Referral Penalty ${patient.name}',
          },
        ),
      );

      /// penalty for ambulance
      balanceRepository.useBalance(
        Receipt(
          balance: ambulanceFees(),
          metadata: {
            'type': 'Ambulance Penalty ${patient.name}',
          },
        ),
      );
    },
  );
}
