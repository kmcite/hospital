import 'package:hospital/main.dart';
import 'package:hospital/models/staff/doctor.dart';
import 'package:hospital/repositories/staff_api.dart';

import '../../models/staff/nurse.dart';
import '../../models/staff/staff.dart';

class GenericStaffsBloc extends Bloc {
  late final StaffRepository staffRepository = watch();
  Iterable<Staff> get staffs => staffRepository.getAll();
}

class GenericStaffsView extends Feature<GenericStaffsBloc> {
  @override
  Widget build(context, controller) {
    return ListView(
      children: List.generate(
        controller.staffs.length,
        (i) {
          final staff = controller.staffs.elementAt(i);
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FilledButton(
                onPressed: staff.isHired ? staff.fire : staff.hire,
                child: Text('${_runtimeType(staff.runtimeType)} ${staff.name}'),
              ),
              LinearProgressIndicator(
                value: staff.energyLevel,
              ).pad(all: 4),
            ],
          );
        },
      ),
    );
  }

  @override
  GenericStaffsBloc create() => GenericStaffsBloc();
}

_runtimeType<T>(T types) {
  return switch (types) {
    Nurse => '[N]',
    Doctor => '[D]',
    _ => "[R]",
  };
}
