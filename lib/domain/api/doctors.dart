import 'package:hospital/domain/models/doctor.dart';
import 'package:hospital/main.dart';

final doctorsRepository = Doctors();

typedef _Doctors = ({
  List<Doctor> hired,
  List<Doctor> availableForHire,
  List<Doctor> onDuty,
});

extension _ on _Doctors {
  // ignore: unused_element
  _Doctors copyWith({
    List<Doctor>? hired,
    List<Doctor>? availableForHire,
    List<Doctor>? onDuty,
  }) {
    return (
      hired: hired ?? this.hired,
      availableForHire: availableForHire ?? this.availableForHire,
      onDuty: onDuty ?? this.onDuty,
    );
  }
}

final _Doctors doctors = (
  hired: [],
  availableForHire: [],
  onDuty: [],
);

class Doctors {
  final doctorsRM = RM.inject(() => doctors);
  _Doctors get state => doctorsRM.state;
  set state(_Doctors _state) => doctorsRM.state = _state;
  List<Doctor> get doctorsAvailableForHire => state.availableForHire;
  List<Doctor> get doctorsHired => state.hired;
  List<Doctor> get doctorsOnDuty => state.onDuty;

  void hire(Doctor doctor) {
    state = state.copyWith(hired: List.of(doctorsHired)..add(doctor));
  }

  void fire(Doctor doctor) {
    state = state.copyWith(hired: List.of(doctorsHired)..remove(doctor));
  }

  void callForDuty(Doctor doctor) {
    state = state.copyWith(onDuty: List.of(doctorsOnDuty)..add(doctor));
  }

  void leave(Doctor doctor) {
    state = state.copyWith(onDuty: List.of(doctorsOnDuty)..remove(doctor));
  }
}
