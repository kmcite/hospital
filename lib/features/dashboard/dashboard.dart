import 'package:forui/forui.dart';
import 'package:hospital/features/dashboard/common_actions.dart';
import 'package:hospital/main.dart';
import 'package:hospital/features/balance/balance.dart';
import 'package:hospital/features/settings/settings.dart';
import 'package:hospital/utils/list_view.dart';

import '../../repositories/generation_api.dart';
import '../../repositories/staff_api.dart';
import 'search_patients.dart';

final remainingTimeForNextPatient = computed<double>(
  () {
    final current = generationRepository.currentRemainingTimeForNext();
    final total = generationRepository.totalRemainingTimeForNext();
    if (current == 0) return 0;
    return current / total;
  },
);

class Dashboard extends UI {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 8,
          children: [
            clinicName.text(textScaleFactor: 2),
            CommonActions(),
            Balance(),
            FProgress(
              value: remainingTimeForNextPatient(),
            ).pad(),
            Expanded(
              child: searchPatients(),
            ),
            Expanded(
              child: listView(
                generationRepository.waitingPatients.values,
                (pt) {
                  return Column(
                    children: [
                      pt.name.text(),
                      FProgress(
                        key: Key(pt.id),
                        value: pt.satisfactionProgress(),
                      ).pad()
                    ],
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

final staffs = computed(
  () => staffRepository.staffs.values,
);
