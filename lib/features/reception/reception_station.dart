import 'package:hospital/main.dart';
import 'package:hospital/repositories/receptions_api.dart';
import 'package:hospital/utils/list_view.dart';
import 'package:hux/hux.dart';

import '../../models/staff/receptionist.dart';
import '../../repositories/staff_api.dart';

class ReceptionStation extends UI {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chitting Room')),
      body: Column(
        children: [
          (staffRepository.currentReceptionist()?.name).text(),
          DropdownMenu(
            label: Text('Employess'),
            width: double.maxFinite,
            dropdownMenuEntries: staffRepository.receptionists().map(
              (employee) {
                return DropdownMenuEntry(
                  value: employee,
                  label: employee.name,
                );
              },
            ).toList(),
            onSelected: (value) {
              if (value is Receptionist) {
                staffRepository.currentReceptionist.set(value);
              }
            },
          ).pad(),
          Expanded(
            child: listView(
              receptionsRepository.receptions.values,
              (chit) => HuxCard(
                title: (chit.patient.name),
                subtitle: (chit.patient.complaints),
                child: chit.notes.text(),
              ).pad(),
            ),
          ),
        ],
      ),
    );
  }
}
