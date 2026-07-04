import 'package:flutter/material.dart';
import 'package:hospital/business/clicker.dart';

import 'package:hospital/business/hospital.dart';
import 'package:hospital/features/main_clicker.dart';
import 'package:hospital/features/clock_card.dart';
import 'package:hospital/utils/navigation.dart';
import 'package:hospital/utils/di.dart';
import 'package:hospital/utils/sm.dart';

final class GameScreen extends UI {
  final HospitalProvider hospital;
  const GameScreen({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            hospital.pauseGame();
            context.pop();
          },
          icon: const Icon(Icons.pause_circle),
        ),
        centerTitle: true,
        title: const Text('Hospital'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Column(
              children: [
                ClockCard(
                  hospital: hospital,
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
          const SizedBox(height: 12),
          MainClicker(
            clicker: context.get(clickerProvider),
          ),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(
                      context,
                    ).colorScheme.primaryContainer.withOpacity(.35),
                    Theme.of(context).colorScheme.surface,
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _RoomNode(
                      title: 'Doctor Room',
                      subtitle: 'Consults',
                      icon: Icons.medical_services,
                      onTap: () => hospital.TreatPatient(),
                      onUpgrade: () {
                        hospital.SpendMoney(500);
                        hospital.AddReputation(5);
                      },
                    ),
                    _RoomNode(
                      title: 'Minor OT',
                      subtitle: 'Procedures',
                      icon: Icons.healing,
                      onTap: () {
                        hospital.SpendMoney(300);
                        hospital.AddReputation(3);
                      },
                      onUpgrade: () {
                        hospital.SpendMoney(300);
                        hospital.AddReputation(3);
                      },
                    ),
                    _RoomNode(
                      title: 'Admin',
                      subtitle: 'Revenue',
                      icon: Icons.business_center,
                      onTap: () {
                        hospital.SpendMoney(300);
                        hospital.AddReputation(3);
                      },
                      onUpgrade: () {
                        hospital.SpendMoney(300);
                        hospital.AddReputation(3);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final class _RoomNode extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool locked;
  final VoidCallback onTap;
  final VoidCallback onUpgrade;

  const _RoomNode({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    required this.onUpgrade,
    this.locked = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Card(
      elevation: 4,
      child: SizedBox(
        width: 160,
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Icon(
                locked ? Icons.lock : icon,
                size: 32,
                color: locked ? color.outline : color.primary,
              ),
              const SizedBox(height: 6),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.filledTonal(
                    tooltip: 'Action',
                    onPressed: locked ? null : onTap,
                    icon: const Icon(Icons.play_arrow),
                  ),
                  const SizedBox(width: 6),
                  IconButton.outlined(
                    tooltip: 'Upgrade',
                    onPressed: locked ? null : onUpgrade,
                    icon: const Icon(Icons.upgrade),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
