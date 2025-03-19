import 'package:forui/forui.dart';
import 'package:hospital/domain/models/patient.dart';
import 'package:hospital/main.dart';
import 'package:hospital/navigator.dart';

final waitingPatientBloc = WaitingPatientBloc();

class WaitingPatientBloc {
  final patientRM = RM.inject(() => Patient());
  late Timer? timer;

  void set state(Patient patient) {
    patientRM
      ..state = patient
      ..notify();
  }

  Patient get state => patientRM.state;

  void mount() {
    timer = Timer.periodic(
      1.seconds,
      (timer) {
        // if (state.remainingTime > 0)
        //   state = state.copyWith(
        //     remainingTime: state.remainingTime - 1,
        //   );
      },
    );
  }

  void unmount() {
    timer?.cancel();
    timer = null;
  }
}

class WaitingPatientPage extends UI {
  void didMountWidget(BuildContext context) => waitingPatientBloc.mount();

  void didUnmountWidget() => waitingPatientBloc.unmount();

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: waitingPatientBloc.state.name.text(),
        prefixActions: [
          FHeaderAction.back(onPress: navigator.back),
        ],
      ),
      content: waitingPatientBloc.state.text(),
    );
  }
}
