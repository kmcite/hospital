import 'package:hospital/main.dart';
import 'package:hux/hux.dart';

import '../../repositories/balance_api.dart';
import '../../models/receipt.dart';
import 'investments.dart';

balance() => GUI(
      () => HuxBadge(
        label: 'PKR ${balanceRepository.balance().toStringAsFixed(0)}',
      ),
    );

// class Balance extends UI {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       spacing: 8,
//       children: [
//         Row(
//           spacing: 8,
//           children: [
//             HuxBadge(
//               label: 'PKR ${balanceRepository.balance().toStringAsFixed(0)}',
//             ),
//             // 'PKR ${balanceRepository.balance().toStringAsFixed(0)}'
//             //     .text(style: TextStyle(fontSize: 16))
//             //     .pad(),
//             patientsRepository
//                 .waitingPatients()
//                 .length
//                 .text(style: TextStyle(fontSize: 16)),
//             IconButton(
//               onPressed: () => hireStaffDialog(context),
//               icon: Icon(FeatherIcons.headphones),
//             ),
//             IconButton(
//               onPressed: () => openMoneyInvestmentDialog(),
//               icon: Icon(FeatherIcons.inbox),
//             ),
//           ],
//         ),
//         Column(
//           children: activeInvestments().map(
//             (investment) {
//               return Column(
//                 children: [
//                   ListTile(
//                     title: Text('PKR ${investment.amount}'),
//                     subtitle: Text('${investment.timeRemaining().inSeconds}s'),
//                     leading: CircularProgressIndicator(
//                       value: 1 -
//                           investment.timeRemaining().inSeconds /
//                               investment.duration.inSeconds,
//                     ),
//                     trailing: Builder(
//                       builder: (context) {
//                         if (investment.isClaimed()) {
//                           return Text(
//                               'PKR${investment.totalReturn().toStringAsFixed(0)}');
//                         } else if (investment.isMatured()) {
//                           return Text(
//                               'PKR ${investment.totalReturn().toStringAsFixed(0)}');
//                         } else {
//                           return IconButton(
//                             onPressed: () => withdrawEarly(investment.id),
//                             icon: Text(
//                                 'PKR ${investment.earlyWithdrawalReturn().toStringAsFixed(0)}'),
//                           );
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ).toList(),
//         ),
//       ],
//     );
//   }
// }

void withdrawEarly(String id) {
  final investment = activeInvestments().firstWhere((i) => i.id == id);
  investment.cancel();
  investment.isWithdrawnEarly.set(true);
  activeInvestments.set([...activeInvestments()..remove(investment)]);
  historyInvestments.set([...historyInvestments(), investment]);
  balanceRepository.unuseBalance(
    Receipt()..balance = investment.earlyWithdrawalReturn(),
  );
}
