// import 'package:flutter/material.dart';
// import 'package:hospital/archived/business/revenue.dart';
// import 'package:hospital/archived/ui/shared/panel_card.dart';
// import 'package:hospital/managers/manager.dart';

// class FinanceReceiptsPanel extends UI {
//   const FinanceReceiptsPanel({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return PanelCard(
//       title: 'Finance Receipts',
//       icon: Icons.receipt_long_outlined,
//       child: ListView(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: _FinanceTotal(
//                   label: 'Income',
//                   amount: totalIncome(),
//                   icon: Icons.arrow_downward,
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: _FinanceTotal(
//                   label: 'Spent',
//                   amount: totalExpenses(),
//                   icon: Icons.arrow_upward,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 14),
//           if (financeReceipts.isEmpty)
//             Text(
//               'No receipts yet.',
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                 color: Theme.of(context).colorScheme.onSurfaceVariant,
//               ),
//             )
//           else
//             for (final receipt in financeReceipts)
//               _ReceiptTile(receipt: receipt),
//         ],
//       ),
//     );
//   }
// }

// class _FinanceTotal extends StatelessWidget {
//   const _FinanceTotal({
//     required this.label,
//     required this.amount,
//     required this.icon,
//   });

//   final String label;
//   final num amount;
//   final IconData icon;

//   @override
//   Widget build(BuildContext context) {
//     return DecoratedBox(
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Icon(icon),
//             const SizedBox(height: 8),
//             Text(label),
//             Text(
//               'Rs. ${amount.toStringAsFixed(0)}',
//               style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                 fontWeight: FontWeight.w800,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ReceiptTile extends StatelessWidget {
//   const _ReceiptTile({required this.receipt});

//   final FinanceReceipt receipt;

//   @override
//   Widget build(BuildContext context) {
//     final color = receipt.isIncome
//         ? Theme.of(context).colorScheme.primary
//         : Theme.of(context).colorScheme.error;
//     final sign = receipt.isIncome ? '+' : '-';

//     return ListTile(
//       contentPadding: EdgeInsets.zero,
//       leading: Icon(
//         receipt.isIncome ? Icons.south_west : Icons.north_east,
//         color: color,
//       ),
//       title: Text(receipt.title),
//       subtitle: Text('${receipt.category} | ${_formatTime(receipt.createdAt)}'),
//       trailing: Text(
//         '$sign Rs. ${receipt.amount.toStringAsFixed(0)}',
//         style: Theme.of(context).textTheme.labelLarge?.copyWith(
//           color: color,
//           fontWeight: FontWeight.w800,
//         ),
//       ),
//     );
//   }
// }

// String _formatTime(DateTime time) {
//   final hour = time.hour.toString().padLeft(2, '0');
//   final minute = time.minute.toString().padLeft(2, '0');
//   final second = time.second.toString().padLeft(2, '0');
//   return '$hour:$minute:$second';
// }
