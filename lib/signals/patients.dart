import 'package:hospital/data/patient.dart';
import 'package:signals/signals.dart';

final patients = listSignal<Patient>([]);
final treatedPatients = listSignal<Patient>([]);
final expiredPatients = listSignal<Patient>([]);
