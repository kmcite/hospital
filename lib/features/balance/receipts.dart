import 'package:hospital/main.dart';
import 'package:hospital/models/investment.dart';
import 'package:hospital/repositories/investments_api.dart';
import 'package:hospital/utils/list_view.dart';
import 'package:hospital/utils/theme.dart';

import '../../repositories/balance_api.dart';

class ReceiptsBloc extends Bloc {
  late final BalanceRepository balanceRepository = watch();

  late final optimizeHistory = balanceRepository.optimizeHistory;
  late final receipts = balanceRepository.getAll();
}

class ReceiptsPage extends Feature<ReceiptsBloc> {
  @override
  ReceiptsBloc create() => ReceiptsBloc();
  @override
  Widget build(context, controller) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipts'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: controller.optimizeHistory,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(HospitalTheme.defaultPadding),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(HospitalTheme.cardPadding),
              decoration: BoxDecoration(
                color: HospitalTheme.successColor.withOpacity(0.1),
                borderRadius:
                    BorderRadius.circular(HospitalTheme.cardBorderRadius),
                border: Border.all(
                    color: HospitalTheme.successColor.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Receipts: ${controller.receipts.length}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: HospitalTheme.successColor,
                    ),
                  ),
                  Text(
                    '\$${controller.receipts.fold(0.0, (a, b) => a + b.balance).toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: HospitalTheme.successColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: HospitalTheme.mediumSpacing),
            Expanded(
              child: listView(
                controller.receipts,
                (item) {
                  return Container(
                    margin: EdgeInsets.only(bottom: HospitalTheme.smallSpacing),
                    child: Card(
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: item.balance >= 0
                                ? HospitalTheme.successColor.withOpacity(0.1)
                                : HospitalTheme.errorColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            item.balance >= 0 ? Icons.add : Icons.remove,
                            color: item.balance >= 0
                                ? HospitalTheme.successColor
                                : HospitalTheme.errorColor,
                          ),
                        ),
                        title: Text(
                          '\$${item.balance.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: item.balance >= 0
                                ? HospitalTheme.successColor
                                : HospitalTheme.errorColor,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (final i in item.metadata.entries)
                              Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  '${i.key}: ${i.value}',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InvestmentsBloc extends Bloc {
  late final InvestmentsRepository investmentsRepository = watch();
  Iterable<Investment> get investments => investmentsRepository.active.values;
  Iterable<Investment> get history => investmentsRepository.history.values;
}

class InvestmentsPage extends Feature<InvestmentsBloc> {
  const InvestmentsPage({super.key});
  @override
  InvestmentsBloc create() => InvestmentsBloc();
  @override
  Widget build(BuildContext context, controller) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Investments'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => navigator.back(),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(HospitalTheme.defaultPadding),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(HospitalTheme.cardPadding),
              decoration: BoxDecoration(
                color: HospitalTheme.infoColor.withOpacity(0.1),
                borderRadius:
                    BorderRadius.circular(HospitalTheme.cardBorderRadius),
                border:
                    Border.all(color: HospitalTheme.infoColor.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Active Investments: ${controller.investments.length}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: HospitalTheme.infoColor,
                    ),
                  ),
                  Text(
                    '\$${controller.investments.fold(0.0, (a, b) => a + b.investedAmount).toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: HospitalTheme.infoColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: HospitalTheme.mediumSpacing),
            Expanded(
              child: listView(
                controller.investments,
                (investment) {
                  return ValueListenableBuilder(
                      valueListenable: investment,
                      builder: (context, value, child) {
                        return Container(
                          margin: EdgeInsets.only(
                              bottom: HospitalTheme.smallSpacing),
                          child: Card(
                            child: ListTile(
                              leading: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color:
                                      HospitalTheme.infoColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(
                                  Icons.trending_up,
                                  color: HospitalTheme.infoColor,
                                ),
                              ),
                              title: Text(
                                investment.id,
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              trailing: Text(
                                '\$${investment.investedAmount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: HospitalTheme.infoColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.all(HospitalTheme.cardPadding),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius:
                    BorderRadius.circular(HospitalTheme.cardBorderRadius),
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'History: ${controller.history.length}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    '\$${controller.history.fold(0.0, (a, b) => a + b.investedAmount).toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: HospitalTheme.mediumSpacing),
            Expanded(
              child: listView(
                controller.history,
                (investment) {
                  return Container(
                    margin: EdgeInsets.only(bottom: HospitalTheme.smallSpacing),
                    child: Card(
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.history,
                            color: Colors.grey[600],
                          ),
                        ),
                        title: Text(
                          investment.id,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        trailing: Text(
                          '\$${investment.investedAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
