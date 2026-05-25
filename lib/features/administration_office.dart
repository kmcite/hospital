import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital/business/money_system.dart';
import 'package:intl/intl.dart';

// Enhanced MoneyReceipt with better encapsulation
class MoneyReceipt {
  final String id;
  final num amount;
  final DateTime timestamp;
  final String reason;
  final String source;
  bool isReversed;

  MoneyReceipt({
    required this.id,
    required this.amount,
    required this.timestamp,
    this.reason = 'General Funding',
    this.source = 'Unknown',
    this.isReversed = false,
  });

  void reverse() {
    if (isReversed) {
      throw StateError('Receipt already reversed');
    }
    isReversed = true;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'timestamp': timestamp.toIso8601String(),
      'reason': reason,
      'source': source,
      'isReversed': isReversed,
    };
  }
}

// Centralized Admin Controller with better state management
class AdminController extends ChangeNotifier {
  final Map<String, MoneyReceipt> _historyOfRequests = {};
  num _money = 50000;
  List<Transaction> _transactions = [];

  // Getters
  Map<String, MoneyReceipt> get historyOfRequests =>
      Map.unmodifiable(_historyOfRequests);
  num get money => _money;
  num get totalRequested => _historyOfRequests.values
      .where((r) => !r.isReversed)
      .fold(0, (sum, r) => sum + r.amount);
  num get availableBalance => _money - totalRequested;
  List<Transaction> get recentTransactions =>
      List.unmodifiable(_transactions.reversed.take(10).toList());

  // Request money with validation
  MoneyReceipt? requestMoney(
    num amount, {
    String reason = 'General Funding',
    String source = 'Admin',
  }) {
    if (amount <= 0) {
      throw ArgumentError('Amount must be greater than 0');
    }

    if (amount > _money) {
      throw StateError('Insufficient funds. Available: $_money');
    }

    final timeStamp = DateTime.now();
    final receipt = MoneyReceipt(
      id: 'REQ-${timeStamp.millisecondsSinceEpoch}',
      amount: amount,
      timestamp: timeStamp,
      reason: reason,
      source: source,
    );

    _historyOfRequests[receipt.id] = receipt;
    _addTransaction(
      Transaction(
        type: TransactionType.request,
        amount: amount,
        reason: reason,
      ),
    );

    _money -= amount;
    notifyListeners();
    return receipt;
  }

  // Reverse a request with proper error handling
  void reverseRequest(String receiptId) {
    final receipt = _historyOfRequests[receiptId];
    if (receipt == null) {
      throw StateError('Receipt not found');
    }

    if (receipt.isReversed) {
      throw StateError('Receipt already reversed');
    }

    receipt.reverse();
    _money += receipt.amount;

    _addTransaction(
      Transaction(
        type: TransactionType.reverse,
        amount: receipt.amount,
        reason: 'Reversed: ${receipt.reason}',
      ),
    );

    notifyListeners();
  }

  // Source funds with validation
  void sourceFunds(num amount, {String source = 'Unknown'}) {
    if (amount <= 0) {
      throw ArgumentError('Amount must be greater than 0');
    }

    _money += amount;

    _addTransaction(
      Transaction(
        type: TransactionType.deposit,
        amount: amount,
        reason: 'Funded from: $source',
      ),
    );

    notifyListeners();
  }

  // Get receipt statistics
  Map<String, dynamic> getStatistics() {
    final reversedReceipts = _historyOfRequests.values
        .where((r) => r.isReversed)
        .length;

    return {
      'totalRequests': _historyOfRequests.length,
      'activeRequests': _historyOfRequests.length - reversedReceipts,
      'reversedRequests': reversedReceipts,
      'totalMoney': _money,
      'totalRequestedAmount': totalRequested,
      'averageRequestAmount': _historyOfRequests.isEmpty
          ? 0
          : _historyOfRequests.values
                    .map((r) => r.amount)
                    .reduce((a, b) => a + b) /
                _historyOfRequests.length,
    };
  }

  void _addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    if (_transactions.length > 100) {
      _transactions.removeAt(0);
    }
  }
}

// Transaction model for history tracking
enum TransactionType { request, reverse, deposit }

class Transaction {
  final TransactionType type;
  final num amount;
  final DateTime timestamp;
  final String reason;

  Transaction({
    required this.type,
    required this.amount,
    required this.reason,
  }) : timestamp = DateTime.now();
}

// Global instance
final adminController = AdminController();

// Enhanced Admin UI
class AdministrationOffice extends StatelessWidget {
  const AdministrationOffice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AdminDashboard();
  }
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics_outlined),
            onPressed: () => _showStatistics(context),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const BalanceCard(),
            const TabBar(
              tabs: [
                Tab(text: 'Requests'),
                Tab(text: 'History'),
                Tab(text: 'Transactions'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: const [
                  RequestsTab(),
                  HistoryTab(),
                  TransactionsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'request',
            onPressed: () => _showRequestDialog(context),
            child: const Icon(Icons.money_off),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'source',
            onPressed: () => _showSourceDialog(context),
            backgroundColor: Colors.green,
            child: const Icon(Icons.add_card),
          ),
        ],
      ),
    );
  }

  void _showRequestDialog(BuildContext context) {
    final amountController = TextEditingController();
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Request Money'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixText: '\$ ',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              try {
                final amount = num.parse(amountController.text);
                adminController.requestMoney(
                  amount,
                  reason: reasonController.text.isNotEmpty
                      ? reasonController.text
                      : 'General Funding',
                );
                Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
                );
              }
            },
            child: const Text('Request'),
          ),
        ],
      ),
    );
  }

  void _showSourceDialog(BuildContext context) {
    final amountController = TextEditingController();
    final sourceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Source Funds'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixText: '\$ ',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: sourceController,
              decoration: const InputDecoration(
                labelText: 'Source',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              try {
                final amount = num.parse(amountController.text);
                adminController.sourceFunds(
                  amount,
                  source: sourceController.text.isNotEmpty
                      ? sourceController.text
                      : 'Unknown',
                );
                Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
                );
              }
            },
            child: const Text('Add Funds'),
          ),
        ],
      ),
    );
  }

  void _showStatistics(BuildContext context) {
    final stats = adminController.getStatistics();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Statistics'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatItem('Total Requests', '${stats['totalRequests']}'),
            StatItem('Active Requests', '${stats['activeRequests']}'),
            StatItem('Reversed Requests', '${stats['reversedRequests']}'),
            StatItem('Total Money', '\$${stats['totalMoney']}'),
            StatItem(
              'Avg Request',
              '\$${stats['averageRequestAmount']?.toStringAsFixed(2)}',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

// Widget Components using AnimatedBuilder/ListenableBuilder
class BalanceCard extends StatelessWidget {
  const BalanceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moneySystem = context.watch<MoneyBloc>();

    return ListenableBuilder(
      listenable: adminController,
      builder: (context, child) {
        return Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BalanceItem(
                  title: 'Balance',
                  amount: moneySystem.state,
                  color: Colors.green,
                ),
                BalanceItem(
                  title: 'Requested',
                  amount: adminController.totalRequested,
                  color: Colors.orange,
                ),
                BalanceItem(
                  title: 'Available',
                  amount: adminController.availableBalance,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BalanceItem extends StatelessWidget {
  final String title;
  final num amount;
  final Color color;

  const BalanceItem({
    Key? key,
    required this.title,
    required this.amount,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class RequestsTab extends StatelessWidget {
  const RequestsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: adminController,
      builder: (context, child) {
        final activeRequests =
            adminController.historyOfRequests.values
                .where((r) => !r.isReversed)
                .toList()
              ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

        if (activeRequests.isEmpty) {
          return const Center(
            child: Text('No active requests'),
          );
        }

        return ListView.builder(
          itemCount: activeRequests.length,
          itemBuilder: (context, index) {
            final receipt = activeRequests[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: ListTile(
                leading: const Icon(Icons.receipt_long, color: Colors.orange),
                title: Text('Amount: \$${receipt.amount}'),
                subtitle: Text(
                  'Reason: ${receipt.reason}\n'
                  'Date: ${DateFormat('MMM dd, yyyy HH:mm').format(receipt.timestamp)}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.undo, color: Colors.red),
                  onPressed: () => _confirmReverse(context, receipt.id),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _confirmReverse(BuildContext context, String receiptId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reverse Request'),
        content: const Text('Are you sure you want to reverse this request?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              try {
                adminController.reverseRequest(receiptId);
                Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Reverse'),
          ),
        ],
      ),
    );
  }
}

class HistoryTab extends StatelessWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: adminController,
      builder: (context, child) {
        final allRequests = adminController.historyOfRequests.values.toList()
          ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

        if (allRequests.isEmpty) {
          return const Center(
            child: Text('No history available'),
          );
        }

        return ListView.builder(
          itemCount: allRequests.length,
          itemBuilder: (context, index) {
            final receipt = allRequests[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: ListTile(
                leading: Icon(
                  receipt.isReversed ? Icons.undo : Icons.receipt,
                  color: receipt.isReversed ? Colors.red : Colors.green,
                ),
                title: Text(
                  '\$${receipt.amount} - ${receipt.reason}',
                  style: TextStyle(
                    decoration: receipt.isReversed
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                subtitle: Text(
                  'ID: ${receipt.id}\n'
                  'Date: ${DateFormat('MMM dd, yyyy HH:mm').format(receipt.timestamp)}',
                ),
                trailing: receipt.isReversed
                    ? const Chip(
                        label: Text('Reversed'),
                        backgroundColor: Colors.red,
                      )
                    : null,
              ),
            );
          },
        );
      },
    );
  }
}

class TransactionsTab extends StatelessWidget {
  const TransactionsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: adminController,
      builder: (context, child) {
        final transactions = adminController.recentTransactions;

        if (transactions.isEmpty) {
          return const Center(
            child: Text('No transactions yet'),
          );
        }

        return ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return ListTile(
              leading: _getTransactionIcon(transaction.type),
              title: Text(
                '${_getTransactionType(transaction.type)}: \$${transaction.amount}',
              ),
              subtitle: Text(
                '${transaction.reason}\n'
                '${DateFormat('MMM dd, HH:mm').format(transaction.timestamp)}',
              ),
            );
          },
        );
      },
    );
  }

  Widget _getTransactionIcon(TransactionType type) {
    switch (type) {
      case TransactionType.request:
        return const Icon(Icons.arrow_upward, color: Colors.red);
      case TransactionType.reverse:
        return const Icon(Icons.undo, color: Colors.orange);
      case TransactionType.deposit:
        return const Icon(Icons.arrow_downward, color: Colors.green);
    }
  }

  String _getTransactionType(TransactionType type) {
    switch (type) {
      case TransactionType.request:
        return 'Request';
      case TransactionType.reverse:
        return 'Reverse';
      case TransactionType.deposit:
        return 'Deposit';
    }
  }
}

class StatItem extends StatelessWidget {
  final String label;
  final String value;

  const StatItem(this.label, this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
