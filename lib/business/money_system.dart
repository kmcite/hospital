import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital/api/chit.dart';
import 'package:hospital/api/models.dart';

class MoneyBloc extends Cubit<int> {
  MoneyBloc() : super(0);
  Chit collectFees(Chit chit) {
    emit(state + chit.fees);
    chit.fees = 0;
    return chit;
  }
}
