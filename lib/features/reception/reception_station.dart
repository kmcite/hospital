import 'package:hospital/main.dart';
import 'package:hospital/repositories/receptions_api.dart';
import 'package:hospital/utils/list_view.dart';
// import 'package:hux/hux.dart'; // Already imported through main.dart

import '../../models/reception.dart';
import '../../models/staff/receptionist.dart';
import '../../repositories/staff_api.dart';

class ReceptionStation extends Feature<ReceptionStationBloc> {
  @override
  Widget build(BuildContext context, controller) {
    return Scaffold(
      appBar: AppBar(title: Text('Chitting Room')),
      body: Column(
        children: [
          Text(controller.currentReceptionist?.name ?? 'No receptionist'),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: DropdownMenu(
              label: Text('Employees'),
              width: double.maxFinite,
              dropdownMenuEntries: controller.receptionists.map(
                (employee) {
                  return DropdownMenuEntry(
                    value: employee,
                    label: employee.name,
                  );
                },
              ).toList(),
              onSelected: (value) {
                if (value is Receptionist) {
                  controller.setCurrentReceptionist(value);
                }
              },
            ),
          ),
          Expanded(
            child: listView(
              controller.receptions,
              (chit) => Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text(chit.patient.target!.name),
                    subtitle: Text(chit.patient.target!.complaints),
                    trailing: Text(chit.notes),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  ReceptionStationBloc create() => ReceptionStationBloc();
}

class ReceptionStationBloc extends Bloc {
  late final receptionsRepository = watch<ReceptionsRepository>();
  late final staffRepository = watch<StaffRepository>();

  /// GLOBAL
  Iterable<Reception> get receptions => receptionsRepository.getAll();
  Receptionist? get currentReceptionist => staffRepository.currentReceptionist;
  Iterable<Receptionist> get receptionists => staffRepository.receptionists;

  late final setCurrentReceptionist = staffRepository.setCurrentReceptionist;
}
