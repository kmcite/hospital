import 'package:forui/forui.dart';
import 'package:hospital/domain/api/faker.dart';
import 'package:hospital/domain/models/doctor.dart';
import 'package:hospital/main.dart';
import 'package:hospital/navigator.dart' show navigator;

mixin HireDoctorBloc {
  final doctorToHire = RM.inject<Doctor>(() => personFaker.name());
}

class HireDoctorDialog extends UI with HireDoctorBloc {
  @override
  Widget build(BuildContext context) {
    return FDialog(
      title: 'HIRE DOCTOR?'.text(),
      body: doctorToHire.state.text(),
      direction: Axis.horizontal,
      actions: [
        FButton.icon(
          onPress: navigator.back,
          child: FIcon(FAssets.icons.x),
        ),
        FButton.icon(
          onPress: doctorToHire.refresh,
          child: FIcon(FAssets.icons.refreshCcw),
        ),
        FButton.icon(
          onPress: () {
            navigator.back(doctorToHire.state);
          },
          child: FIcon(FAssets.icons.checkCheck),
        ),
      ],
    );
  }
}
