import 'package:hospital/main.dart';

import '../models/investment.dart';

// class InvestmentsRepository extends Repository {
//   final activeInvestments = Map<String, Investment>();
//   final historyInvestments = Map<String, Investment>();

//   void activate(Investment investment) {
//     activeInvestments[investment.id] = investment;
//     notifyListeners();
//   }

//   void archive(Investment inv) {
//     final removedFromActive = activeInvestments.remove(inv.id);
//     if (removedFromActive == null) return;

//     historyInvestments[removedFromActive.id] = removedFromActive;
//     notifyListeners();
//   }
// }

class InvestmentsRepository extends Repository {
  final Map<String, Investment> _active = {};
  final Map<String, Investment> _history = {};

  Map<String, Investment> get active => Map.unmodifiable(_active);
  Map<String, Investment> get history => Map.unmodifiable(_history);

  void activate(Investment investment) {
    _active[investment.id] = investment;
    notifyListeners();
  }

  void archive(Investment investment) {
    if (!_active.containsKey(investment.id)) return;
    if (_history.containsKey(investment.id)) return; // Idempotency guard

    _active.remove(investment.id);
    _history[investment.id] = investment;
    notifyListeners();
  }
}
