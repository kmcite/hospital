import 'package:hospital/main.dart';

final funds = Funds();

class Funds {
  final hospitalFundsRM = RM.inject<double>(() => 1000);
  final chairtyFundsRM = RM.inject<double>(() => 1000);
  double get hospitalFunds => hospitalFundsRM.state;
  double get charityFunds => chairtyFundsRM.state;

  addHospitalFunds(double amount) {
    hospitalFundsRM.state = hospitalFunds + amount;
  }

  useHospitalFunds(double amount) {
    hospitalFundsRM.state = hospitalFunds - amount;
  }

  addCharityFunds(double amount) {
    chairtyFundsRM.state = charityFunds + amount;
  }

  useCharityFunds(double amount) {
    chairtyFundsRM.state = charityFunds - amount;
  }
}
