import 'package:hospital/main.dart';
import 'package:hospital/repositories/patients_api.dart';
import 'package:hospital/repositories/receptions_api.dart';
import 'package:hospital/repositories/settings_api.dart';
import 'package:hospital/utils/list_view.dart';
// import 'package:hux/hux.dart'; // Already imported through main.dart

import '../../repositories/balance_api.dart';
import '../../models/patient.dart';

class WaitingPatientsBloc extends Bloc {
  late final BalanceRepository balanceRepository = watch();
  late final ReceptionsRepository receptionsRepository = watch();
  late final SettingsRepository settingsRepository = watch();
  late PatientsRepository patientsRepository = watch();

  Iterable<Patient> get waiting => patientsRepository.waiting;

  void manage(Patient patient) => patientsRepository.manage(patient);

  void referPatientElsewhere(Patient patient) {
    patientsRepository.refer(patient);
  }
}

class WaitingPatientsList extends Feature<WaitingPatientsBloc> {
  const WaitingPatientsList({super.key});
  @override
  WaitingPatientsBloc create() => WaitingPatientsBloc();
  @override
  Widget build(BuildContext context, WaitingPatientsBloc controller) {
    return listView(
      controller.waiting,
      (patient) {
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            title: Text(patient.name),
            subtitle: Text(patient.complaints),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.local_activity),
                ),
                IconButton(
                  onPressed: () {
                    controller.referPatientElsewhere(patient);
                  },
                  icon: Icon(Icons.arrow_outward),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

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
