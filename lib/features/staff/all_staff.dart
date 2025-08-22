import 'package:flutter/foundation.dart';
import 'package:forui/forui.dart';
import 'package:hospital/features/dashboard/dashboard.dart';
import 'package:hospital/main.dart';
import 'package:hospital/models/staff/doctor.dart';
import 'package:hospital/utils/list_view.dart';
import 'package:hospital/utils/navigator.dart';

import '../../models/staff/staff.dart';
import 'staff.dart';

_type(Type staff) {
  return switch (staff) { Staff => 'R', Doctor => 'D', _ => 'N' };
}

class AllStaffs extends UI {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: Text(
          'All Staffs',
        ),
        prefixes: [
          FHeaderAction.back(
            onPress: navigator.back,
          ),
        ],
      ),
      child: listView(
        staffs(),
        (staff) {
          return FTile(
            title: Text(
              '${staff.name} ${_type(staff.runtimeType)}',
            ),
            subtitle: GUI(
              () => Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildStatusRow(
                    'Working',
                    staff.isWorking,
                    Colors.blue,
                  ),
                  _buildStatusRow(
                    'Resting',
                    staff.isResting,
                    Colors.green,
                  ),
                  _buildStatusRow(
                    'Exhausted',
                    staff.isExhausted,
                    Colors.red,
                  ),
                  FProgress(
                    value: clampDouble(staff.currentDuty(), 0, 1),
                  ),
                ],
              ),
            ),
            onPress: () => navigator.to(StaffPage(staff: staff)),
          );
        },
      ),
    );
  }

  Widget _buildStatusRow(String label, Signal<bool> value, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: value() ? color : Colors.grey[300],
          ),
        ),
        SizedBox(width: 8),
        Text(
          '$label: ${value() ? 'Yes' : 'No'}',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }
}
