import 'package:hospital/main.dart';
import 'package:hospital/utils/list_view.dart';

import '../../repositories/balance_api.dart';

class ReceiptsPage extends UI {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipts'),
        // prefixes: [
        //   FHeaderAction.x(onPress: navigator.back),
        // ],
        actions: [
          // FHeaderAction(
          //   icon: Icon(FIcons.refreshCcw),
          //   onPress: balanceRepository.archiveCurrentBalanceIntoHistory,
          // ),
        ],
      ),
      body: listView(
        balanceRepository.receipts.values,
        (item) {
          return ListTile(
            title: Text(item.balance.toString()),
            subtitle: Text(item.metadata.toString()),
          );
        },
      ),
    );
  }
}
