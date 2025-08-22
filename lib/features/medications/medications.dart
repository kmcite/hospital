import 'package:forui/forui.dart';
import 'package:hospital/main.dart';
import 'package:hospital/repositories/medications_api.dart';
import 'package:hospital/utils/list_view.dart';
import 'package:hospital/utils/navigator.dart';
import 'package:hux/hux.dart';

import '../../models/medication.dart';

class MedicationsPage extends UI {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        prefixes: [
          FHeaderAction.back(onPress: navigator.back),
        ],
        title: Text('Medications'),
        suffixes: [
          FHeaderAction(
            icon: Icon(FeatherIcons.plus),
            onPress: () => medicationsRepository.putMedication(Medication()),
          ),
        ],
      ),
      child: listView(
        medicationsRepository.medications(),
        (item) {
          return HuxCard(
            child: Text(item.name),
            subtitle: item.amount.toString(),
            onTap: () => medicationsRepository.removeMedication(item),
          );
        },
      ),
    );
  }
}
