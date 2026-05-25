import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital/api/models.dart';
import 'package:hospital/api/repositories.dart';
import 'package:hospital/business/reception_controller.dart';

class ReceptionistsCubit extends Cubit<ReceptionistsState> {
  final ReceptionistsRepository receptionistsRepository;
  ReceptionistsCubit(this.receptionistsRepository)
    : super(ReceptionistsState());

  void put(Receptionist recep) {
    receptionistsRepository.put(recep);
  }

  void remove(String id) {}

  Chit? createChit(Patient patient) {
    return state.current?.createChit(patient);
  }

  // Counter management
  void toggleCounter() {
    // _counterOpen = !_counterOpen;
    // if (!_counterOpen) {
    //   _activeReceptionistId = null;
    // } else if (activeReceptionist == null) {
    //   _assignNextAvailable();
    // }
    // notifyListeners();
  }

  void openCounter() {
    if (!state.isCounterOpen) {
      emit(state..isCounterOpen = true);
      // _assignNextAvailable();
      // notifyListeners();
    }
  }

  void closeCounter() {
    // if (_counterOpen) {
    //   _counterOpen = false;
    //   _activeReceptionistId = null;
    //   notifyListeners();
    // }
  }
}
