import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital/api/consultation.dart';
import 'package:hospital/api/models.dart';

class NursingBloc extends Cubit<List<Consultation>> {
  NursingBloc() : super([]);
  final List<Consultation> treatments = [];
  void treat(Consultation consultation) {
    treatments.add(consultation);
  }
}
