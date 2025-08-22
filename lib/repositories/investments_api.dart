import 'package:hospital/main.dart';

import 'balance_api.dart';
import '../models/investment.dart';
import '../models/receipt.dart';

final activeInvestments = listSignal(<Investment>[]);
final historyInvestments = listSignal(<Investment>[]);
Future<void> invest({
  required double amount,
  required Duration duration,
}) async {
  double calculateProfitRate(Duration duration) {
    final seconds = duration.inSeconds;
    if (seconds <= 1) return 0.01; // 1%
    if (seconds <= 3) return 0.03; // 3%
    if (seconds <= 7) return 0.07; // 7%
    if (seconds <= 15) return 0.10; // 10%
    if (seconds <= 30) return 0.15; // 15%
    return 0.20; // max 20%
  }

  final rate = calculateProfitRate(duration);

  final investment = Investment(
    id: faker.guid.guid(),
    amount: amount,
    duration: duration,
    profitRate: rate,
  );

  investment.start(
    () {
      autoClaim(investment.id);
    },
  );

  activeInvestments.set(
    [...activeInvestments(), investment],
  );
}

void autoClaim(String id) {
  final investment = activeInvestments().firstWhere((i) => i.id == id);
  investment.isClaimed.set(true);
  activeInvestments.set([...activeInvestments()..remove(investment)]);
  historyInvestments.set([...historyInvestments(), investment]);
  balanceRepository.unuseBalance(Receipt()..balance = investment.totalReturn());
}
