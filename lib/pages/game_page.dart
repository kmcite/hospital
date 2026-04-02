import 'package:flutter/material.dart';
import 'package:hospital/components/ui.dart';
import 'package:hospital/signals/game_logic.dart';
import 'package:hospital/components/patient_card.dart';
import 'package:hospital/signals/patients.dart';
import 'package:hospital/components/quit_button.dart';
import 'package:hospital/signals/money.dart';

class GamePage extends UI {
  const GamePage({super.key});

  @override
  void init(BuildContext context) {
    if (gameTickTimer == null) {
      startGameLogic();
    }
  }

  @override
  void dispose() {
    stopGameLogic();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShouldQuit(
      child: DefaultTabController(
        length: PatientTab.values.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Hospital',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            leading: QuitButton(),
            actions: [
              IconButton(
                onPressed: () => isGameRunning.set(!isGameRunning()),
                icon: Icon(isGameRunning() ? Icons.pause : Icons.play_arrow),
              ),
              const SizedBox(width: 8),
            ],
            bottom: TabBar(
              tabs: PatientTab.values
                  .map(
                    (p) => Tab(
                      text: p.name.toUpperCase(),
                    ),
                  )
                  .toList(),
            ),
          ),
          body: TabBarView(
            children: PatientTab.values.map(
              (tab) {
                final displayList = tab == PatientTab.active
                    ? patients
                    : tab == PatientTab.treated
                    ? treatedPatients
                    : expiredPatients;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: displayList.length,
                  itemBuilder: (context, index) {
                    final patient = displayList[index];
                    return PatientCard(patient: patient);
                  },
                );
              },
            ).toList(),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 0.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.airport_shuttle, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 150),
                          tween: Tween<double>(
                            begin: (spawnTimer() / maxSpawnTimer()).clamp(
                              0.0,
                              1.0,
                            ),
                            end: (spawnTimer() / maxSpawnTimer()).clamp(
                              0.0,
                              1.0,
                            ),
                          ),
                          builder: (context, value, _) {
                            final isDelay = isSpawnDelay();
                            return LinearProgressIndicator(
                              value: value,
                              minHeight: 8,
                              borderRadius: BorderRadius.circular(4),
                              color: isDelay
                                  ? Colors.blueAccent
                                  : Colors.orangeAccent,
                              backgroundColor: isDelay
                                  ? Colors.blue.withValues(alpha: 0.2)
                                  : Colors.orange.withValues(alpha: 0.2),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 44,
                        child: Text(
                          '${spawnTimer().toStringAsFixed(1)}s',
                          textAlign: TextAlign.end,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Money: \$${money().toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text('Active: ${patients.length}'),
                      Text(
                        'Treated: ${treatedPatients.length}',
                        style: const TextStyle(color: Colors.green),
                      ),
                      Text(
                        'Expired: ${expiredPatients.length}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum PatientTab { active, treated, expired }
