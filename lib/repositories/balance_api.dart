import 'dart:async';

import '../main.dart';
import '../models/receipt.dart';

final _initialReceipt = Receipt(
  customId: '_initialReceipt',
  balance: 150000,
);

/// EVENTS TO UPDATE BALANCE

class BalanceEvents {
  const BalanceEvents();
}

class SalaryImbursement extends BalanceEvents {
  final double salary;
  final String employeeId;
  const SalaryImbursement(this.salary, this.employeeId);
}

class AmbulancePayment extends BalanceEvents {
  final double amount;
  final String patientId;
  const AmbulancePayment(this.amount, this.patientId);
}

/// POSITIVE

class BillsAndFeesFromPatients extends BalanceEvents {
  final double amount;
  final String patientId;
  const BillsAndFeesFromPatients(this.amount, this.patientId);
}

class GovernmentFunds extends BalanceEvents {
  final double amount;
  GovernmentFunds(this.amount);
}

class Donation extends BalanceEvents {
  final double amount;
  final String donorId;
  const Donation(this.amount, this.donorId);
}

final balanceRepository = BalanceRepository();

class BalanceRepository {
  final controller = StreamController<BalanceEvents>.broadcast();
  void send<E extends BalanceEvents>(E event) {
    controller.add(event);
  }

  BalanceRepository() {
    controller.stream.listen(
      (event) {
        /// negative means hospital money is used to provide for salary
        /// positive means hospital money is increased
        if (event is SalaryImbursement) {
          final receipt = Receipt(
            balance: -event.salary,
            metadata: {
              'employeeId': event.employeeId,
              'type': SalaryImbursement,
            },
          );
          receipts[receipt.id] = receipt;
        } else if (event is AmbulancePayment) {
          final receipt = Receipt(
            balance: -event.amount,
            metadata: {
              'patientId': event.patientId,
              'type': AmbulancePayment,
            },
          );
          receipts[receipt.id] = receipt;
        } else if (event is BillsAndFeesFromPatients) {
          final receipt = Receipt(
            balance: event.amount,
            metadata: {
              'patientId': event.patientId,
              'type': BillsAndFeesFromPatients,
            },
          );
          receipts[receipt.id] = receipt;
        } else if (event is Donation) {
          final receipt = Receipt(
            balance: event.amount,
            metadata: {
              'donorId': event.donorId,
              'type': Donation,
            },
          );
          receipts[receipt.id] = receipt;
        } else if (event is GovernmentFunds) {
          final receipt = Receipt(
            balance: event.amount,
            metadata: {
              'type': GovernmentFunds,
            },
          );
          receipts[receipt.id] = receipt;
        } else {
          throw UnimplementedError('');
        }
      },
    );
  }

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
    final update = Receipt(
      customId: _initialReceipt.id,
      metadata: {
        'type': 'ClearBalanceHistory',
      },
      balance: balance(),
    );
    receipts.clear();
    receipts[update.id] = update;
  }

  // Live computed total balance from all receipts
  late final balance = computed(
    () => receipts.values.fold(0.0, (sum, r) => sum + r.balance),
  );
}
