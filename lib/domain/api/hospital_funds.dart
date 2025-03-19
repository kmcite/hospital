// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hospital/main.dart';

final hospitalFundsRepository = HospitalFunds();

class HospitalFunds extends ChangeNotifier {
  int hospitalFunds = 1000;
  int charityFunds = 1000;
  void addHospitalFunds(int amount) {
    hospitalFunds = hospitalFunds + amount;
    notifyListeners();
  }

  void useHospitalFunds(int amount) {
    hospitalFunds = hospitalFunds - amount;
    notifyListeners();
  }

  void addCharityFunds(int amount) {
    charityFunds = charityFunds + amount;
    notifyListeners();
  }

  void useCharityFunds(int amount) {
    charityFunds = charityFunds - amount;
    notifyListeners();
  }
}
