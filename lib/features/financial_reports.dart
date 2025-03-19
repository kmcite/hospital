import 'package:hospital/main.dart';

class FinancialReports extends UI {
  const FinancialReports({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Financial Reports:'),
        // ...hospitalBloc.financialReports.map((report) => ListTile(
        //       title: Text(report),
        //     )),
      ],
    );
  }
}
