// import 'package:forui/forui.dart'; // Removed - using Material Design
import 'package:hospital/main.dart';
import 'package:hospital/repositories/medications_api.dart';
import 'package:hospital/utils/list_view.dart';

// import 'package:hux/hux.dart'; // Already imported through main.dart

import '../../models/medication.dart';

class MedicationsPage extends Feature<MedicationsBloc> {
  @override
  Widget build(BuildContext context, controller) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: navigator.back,
        ),
        title: Text('Medications'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => medicationsRepository.putMedication(Medication()),
          ),
        ],
      ),
      body: listView(
        medicationsRepository.medications,
        (item) {
          return ListTile(
            title: Text(item.name),
            subtitle: Text(item.amount.toString()),
            onTap: () => medicationsRepository.removeMedication(item),
          );
        },
      ),
    );
  }

  @override
  MedicationsBloc create() => MedicationsBloc();
}

class MedicationsBloc extends Bloc {}
