import '../main.dart';
import '../models/receipt.dart';

final _initialReceipt = Receipt(
  customId: '_initialReceipt',
  balance: 150000,
);

final balanceRepository = BalanceRepository();

class BalanceRepository {
  final receipts = mapSignal<String, Receipt>(
    {_initialReceipt.id: _initialReceipt},
  );

  /// Revert a receipt (negate amount)
  void useBalance(Receipt r) {
    final balance = r.balance;
    final updated = r..balance = -balance;
    receipts[updated.id] = updated;
  }

  /// Add or update a receipt
  void unuseBalance(Receipt r) {
    receipts[r.id] = r;
  }

  /// Archive the current balance into history
  void archiveCurrentBalanceIntoHistory() {
    final newReceipt = Receipt()
      ..id = _initialReceipt.id
      ..details = 'ClearBalanceHistory'
      ..balance = balance();
    receipts.clear();
    receipts[newReceipt.id] = newReceipt;
  }

  // Live computed total balance from all receipts
  late final balance = computed(
    () => receipts.values.fold(0.0, (sum, r) => sum + r.balance),
  );
}
