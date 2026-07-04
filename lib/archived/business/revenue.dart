// import 'dart:async';

// import 'package:hospital/managers/manager.dart';

// enum FinanceReceiptType { income, expense }

// class FinanceReceipt {
//   const FinanceReceipt({
//     required this.id,
//     required this.type,
//     required this.amount,
//     required this.title,
//     required this.category,
//     required this.createdAt,
//   });

//   final String id;
//   final FinanceReceiptType type;
//   final num amount;
//   final String title;
//   final String category;
//   final DateTime createdAt;

//   bool get isIncome => type == FinanceReceiptType.income;
// }

// final hospitalRevenue = signal<num>(25000);
// final revenueRate = signal<num>(1);
// final financeReceipts = listSignal(<FinanceReceipt>[]);
// final totalIncome = signal<num>(0);
// final totalExpenses = signal<num>(0);
// Timer? _revenueTimer;

// void startRevenueGeneration() {
//   _revenueTimer ??= Timer.periodic(
//     const Duration(seconds: 1),
//     (_) => updateRevenue(),
//   );
// }

// void updateRevenue() {
//   earnMoney(revenueRate.value, 'Operations revenue', 'Revenue');
// }

// void earnMoney([
//   num amount = 500,
//   String title = 'Patient fee',
//   String category = 'Care',
// ]) {
//   if (amount <= 0) return;
//   hospitalRevenue.value += amount;
//   totalIncome.value += amount;
//   _addReceipt(
//     FinanceReceiptType.income,
//     amount,
//     title: title,
//     category: category,
//   );
// }

// bool spendMoney(
//   num amount, {
//   required String title,
//   required String category,
// }) {
//   if (amount <= 0) return true;
//   if (hospitalRevenue.value < amount) return false;

//   hospitalRevenue.value -= amount;
//   totalExpenses.value += amount;
//   _addReceipt(
//     FinanceReceiptType.expense,
//     amount,
//     title: title,
//     category: category,
//   );
//   return true;
// }

// void _addReceipt(
//   FinanceReceiptType type,
//   num amount, {
//   required String title,
//   required String category,
// }) {
//   financeReceipts.insert(
//     0,
//     FinanceReceipt(
//       id: DateTime.now().microsecondsSinceEpoch.toString(),
//       type: type,
//       amount: amount,
//       title: title,
//       category: category,
//       createdAt: DateTime.now(),
//     ),
//   );

//   if (financeReceipts.length > 160) {
//     financeReceipts.removeLast();
//   }
// }
