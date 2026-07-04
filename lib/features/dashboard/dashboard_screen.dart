import 'package:flutter/material.dart';
import 'package:hospital/features/clicker/main_clicker.dart';
import 'package:hospital/features/clicker/clicker_action.dart';
import 'package:hospital/features/clock/clock_card.dart';
import 'package:hospital/features/dashboard/dashboard_action.dart';
import 'package:hospital/features/hospital/hospital.dart';
import 'package:hospital/features/navigation/navigation_action.dart';
import 'package:hospital/features/stats/stats_card.dart';
import 'package:hospital/features/stats/stats_screen.dart';
import 'package:hospital/game/game_scope.dart';

final class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final stats = HospitalStatsManager();
    final clock = context.select((state) => state.clock);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.apply(PauseRunningGame());
          },
          icon: const Icon(Icons.exit_to_app),
        ),
        centerTitle: true,
        title: const Text('Hospital'),
        actions: [
          IconButton(
            tooltip: 'Stats ${clock.hour}',
            onPressed: () => context.apply(PushScreen(const StatsScreen())),
            icon: const Icon(Icons.bar_chart),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Column(
              children: [
                ClockCard(),
                SizedBox(height: 12),
                StatsCard(),
              ],
            ),
          ),
          const SizedBox(height: 12),

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
                      onTap: () => context.apply(TreatPatient()),
                      onUpgrade: () {
                        context.apply(SpendMoney(500));
                        context.apply(AddReputation(5));
                      },
                    ),
                    _RoomNode(
                      title: 'Minor OT',
                      subtitle: 'Procedures',
                      icon: Icons.healing,
                      onTap: () {
                        context.apply(SpendMoney(300));
                        context.apply(AddReputation(3));
                      },
                      onUpgrade: () {
                        context.apply(SpendMoney(800));
                        context.apply(AddReputation(8));
                      },
                    ),
                    _RoomNode(
                      title: 'Admin',
                      subtitle: 'Revenue',
                      icon: Icons.business_center,
                      onTap: () {
                        context.apply(SpendMoney(200));
                      },
                      onUpgrade: () {
                        context.apply(SpendMoney(1000));
                        context.apply(AddReputation(10));
                      },
                    ),
                    MainClicker(onTap: () => context.apply(ClickerTapped())),
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
