import 'package:hospital/models/patient.dart';
import 'package:hospital/utils/list_view.dart';
// import 'package:hux/hux.dart'; // Already imported through main.dart

import '../../main.dart';
import '../../repositories/patients_api.dart';

class ReferredPatientsBloc extends Bloc {
  late final PatientsRepository patientsRepository = watch();
  Iterable<Patient> get referred => patientsRepository.referred;
}

class ReferredPatients extends Feature<ReferredPatientsBloc> {
  @override
  ReferredPatientsBloc create() => ReferredPatientsBloc();

  @override
  Widget build(BuildContext context, controller) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reffered Patients'),
      ),
      body: listView(
        controller.referred,
        (patient) {
          return Card(
            child: ListTile(
              title: Text(patient.name),
              subtitle: Text(patient.complaints),
              trailing: Text(patient.status.name),
            ),
          );
        },
      ),
    );
  }
}
