import 'package:objectbox/objectbox.dart';

import '../main.dart';
import '../models/receipt.dart';

class BalanceRepository extends Repository {
  final store = find<Store>();
  late final box = store.box<Receipt>();

  Iterable<Receipt> getAll() => box.getAll();

  /// READ
  double get balance => getAll().fold(0.0, (sum, r) => sum + r.balance);

  /// CREATE UPDATE & DELETE
  void put(Receipt receipt) {
    box.put(receipt);
  }

  void remove(Receipt receipt) {
    box.remove(receipt.id);
  }

  void optimizeHistory() {
    final receipt = Receipt(
      metadata: {
        'type': 'Optimize',
      },
      balance: balance,
    );
    box.removeAll();
    put(receipt); // no need of notify
  }
}
