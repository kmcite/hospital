import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital/api/models.dart';

class DoctorBloc extends Cubit<Map<Chit, Consultation>> {
  DoctorBloc() : super({});
  Consultation prescribe(Chit chit) {
    final consultation = Consultation(chit);
    final copy = state..[chit] = consultation;
    emit(Map.of(copy));
    return consultation;
  }
}
