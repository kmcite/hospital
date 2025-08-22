import 'package:hospital/main.dart';
import 'package:hospital/models/staff/doctor.dart';

import '../../models/staff/nurse.dart';
import '../../models/staff/staff.dart';
import 'dashboard.dart';

List<Widget> GenericStaffsUI<T extends Staff>() {
  return List.generate(
    staffs().length,
    (i) {
      final staff = staffs().elementAt(i);
      return GUI(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilledButton(
              onPressed: staff.isHired() ? staff.fire : staff.hire,
              child: Text('${_runtimeType(staff.runtimeType)} ${staff.name}'),
            ),
            LinearProgressIndicator(
              value: staff.currentDuty(),
            ).pad(all: 4),
          ],
        ),
      );
    },
  );
}

_runtimeType<T>(T types) {
  return switch (types) {
    Nurse => '[N]',
    Doctor => '[D]',
    _ => "[R]",
  };
}
