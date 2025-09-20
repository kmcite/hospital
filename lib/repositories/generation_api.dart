import 'package:hospital/main.dart';

import '../models/patient.dart';

class GenerationRepository extends Repository {
  GenerationRepository() {
    generator();
    autoRemoveUnsatisfied();
  }
  var unsatisfiedPatients = <String, Patient>{};
  var waitingPatients = <String, Patient>{};
  var currentRemainingTimeForNext = 0;
  var totalRemainingTimeForNext = 1;

  void generator() async {
    // while (true) {
    //   final duration = faker.randomGenerator.integer(10, min: 5);
    //   totalRemainingTimeForNext = duration;
    //   currentRemainingTimeForNext = duration;
    //   while (currentRemainingTimeForNext > 0) {
    //     await Future.delayed(Duration(seconds: 1));
    //     currentRemainingTimeForNext--;
    //     notifyListeners();
    //   }
    //   final pt = Patient();
    //   waitingPatients[pt.id] = pt;
    //   notifyListeners();
    // }
  }

  void autoRemoveUnsatisfied() async {
    // while (true) {
    //   await Future.delayed(Duration(seconds: 1));
    //   List<Patient> unsatisfied = [];
    //   for (var pt in waitingPatients.values) {
    //     if (!pt.isSatisfied) {
    //       unsatisfied.add(pt);
    //     }
    //   }
    //   for (final pt in unsatisfied) {
    //     waitingPatients.remove(pt.id);
    //     unsatisfiedPatients[pt.id] = pt;
    //   }
    //   notifyListeners();
    // }
  }
}
