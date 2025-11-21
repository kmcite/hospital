import 'dart:developer';

import 'package:hospital/main.dart';

import 'doctor_room/doctor_room.dart';

//  │       ├── MinorOTView
//  │       │   ├── OT Staff Info
//  │       │   ├── Procedure List
//  │       │   └── Procedure Card
//  │       │       └── Name / Timer / Reward / Start Button

/// minor ot
/// where minor operating procedure happens
/// procedures should be started, takes time & upon completion
/// player gets reward.
/// 1. ot staff currently on duty information
/// 2. procedure list
/// 3. procedure card
/// 4. procedure card should have name, timer, reward & start button

class MinorOTNotifier extends ChangeNotifier {}

class MinorOT extends StatelessTab {
  const MinorOT({super.key});

  @override
  String get name => 'Minor OT';

  @override
  Widget build(BuildContext context) {
    return NotifierProvider(
      create: (context) => MinorOTNotifier(),
      builder: (context, minorOT) {
        return CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverList.list(
              children: [
                OTStaffInformation(),
                ProcedureList(),
              ],
            ),
          ],
        );
      },
    );
  }
}

class OTStaffInformation extends StatelessWidget {
  const OTStaffInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FTile(
          title: Text('Onduty OT Staff'),
          subtitle: Text('Mr. Khubaib'),
        ),
      ],
    );
  }
}

class ProcedureList extends StatelessWidget {
  const ProcedureList({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        SliverList.list(
          children: [
            ProcedureCard(),
          ],
        ),
      ],
    );
  }
}

class ProcedureCard extends StatelessWidget {
  const ProcedureCard({super.key});

  void onProcedureStarted() {
    log('procedure started');
  }

  @override
  Widget build(BuildContext context) {
    return FTile(
      title: Text('procedure card => name'),
      subtitle: Text('procedure card => description'),
      suffix: FButton.icon(
        onPress: onProcedureStarted,
        child: Icon(FIcons.arrowRight),
      ),
    );
  }
}
