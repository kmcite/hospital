import 'package:flutter/material.dart';
import 'package:hospital/features/dashboard/common_actions.dart';
import 'package:hospital/features/dashboard/remaining_time_for_next_ui.dart';
import 'package:hospital/main.dart';
import 'package:hospital/features/balance/balance.dart';
import 'package:hospital/features/settings/settings.dart';

import '../../repositories/generation_api.dart';
import '../../repositories/staff_api.dart';

final progress = computed(
  () {
    return generationRepository.currentRemainingTimeForNext() /
        generationRepository.totalRemainingTimeForNext();
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
            balance(),
            AnimatedProgressBar(progress: progress),
            // Expanded(child: searchPatients()),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: genericStaffsUI().length,
            //     itemBuilder: (c, i) => genericStaffsUI().elementAt(i),
            //   ),
            // ),
            Expanded(
              child: GUI(
                () => ListView(
                  children: [
                    // for (final pt in receptionistQueue.values)
                    //   GUI(
                    //     () => Column(
                    //       children: [
                    //         pt.name.text(),
                    //         AnimatedProgressBar(
                    //           key: Key(pt.id),
                    //           progress: pt.satisfactionProgress,
                    //         ).pad(),
                    //       ],
                    //     ),
                    //   ),
                    for (final pt
                        in generationRepository.waitingPatients.values)
                      GUI(
                        () => Column(
                          children: [
                            pt.name.text(),
                            AnimatedProgressBar(
                              key: Key(pt.id),
                              progress: pt.satisfactionProgress,
                            )
                          ],
                        ),
                      ),
                    Text('UNSATISFIED'),
                    Column(
                      children: List.generate(
                        generationRepository.unsatisfiedPatients.length,
                        (i) {
                          final pt = generationRepository
                              .unsatisfiedPatients.values
                              .elementAt(i);
                          return pt.name.text();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final staffs = computed(
  () => [
    ...staffRepository.doctors.values,
    ...staffRepository.nurses.values,
    ...staffRepository.receptionists.values,
  ],
);
