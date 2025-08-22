import 'package:hospital/utils/list_view.dart';
import 'package:hux/hux.dart';

import '../../main.dart';
import '../../repositories/patients_api.dart';

class ReferredPatients extends UI {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Referred Patients'),
      ),
      body: listView(
        referredPatients.values,
        (patient) {
          return HuxCard(
            title: patient.name,
            subtitle: patient.complaints,
            child: Text(patient.name),
          );
        },
      ),
    );
  }
}
