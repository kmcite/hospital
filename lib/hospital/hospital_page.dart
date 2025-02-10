import 'package:hospital/hospital/finances/hospital_funds.dart';
import 'package:hospital/hospital/navigator/app_scaffold.dart';
import 'package:hospital/hospital/patients/admitted/admitted_patients_bloc.dart';
import 'package:hospital/hospital/patients/waiting/waiting_button.dart';
import 'package:hospital/hospital/patients/waiting/waiting_patients_bloc.dart';
import 'package:hospital/main.dart';
import 'package:icons_plus/icons_plus.dart';
import 'hospital_bloc.dart';

class HospitalPage extends UI {
  const HospitalPage({super.key});
  IconData _mapSpeedToIcon(double speed) {
    if (speed <= 1) return Icons.looks_one;
    if (speed <= 2) return Icons.looks_two;
    if (speed <= 3) return Icons.looks_3;
    if (speed <= 4) return Icons.looks_4;
    if (speed <= 5) return Icons.looks_5;
    return Icons.speed; // Default fallback
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Icon(FontAwesome.hospital, size: 28),
        actions: [
          hospitalBloc.elapsedTime
              .text(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cascadia Code',
                ),
              )
              .pad(),
          IconButton(
            tooltip:
                'Speed: ${hospitalBloc.speedMultiplier.toStringAsFixed(1)}x',
            icon: Icon(_mapSpeedToIcon(hospitalBloc.speedMultiplier)),
            onPressed: hospitalBloc.toggleSpeed,
          ),
          // Play/Pause Button
          IconButton(
            tooltip: hospitalBloc.isRunning ? 'pause' : 'start',
            icon: Icon(
              hospitalBloc.isRunning ? Icons.pause_circle : Icons.play_circle,
            ),
            onPressed: hospitalBloc.isRunning
                ? hospitalBloc.pause
                : hospitalBloc.start,
          ).pad(right: 8),
        ],
      ),
      body: Column(
        spacing: 16,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 12,
                  children: [
                    'HospFunds: ${funds.hospitalFunds}'.text(),
                    // 'TreatedPatients: ${hospitalBloc.treatedPatients}'.text(),
                    // 'Beds: ${hospitalBloc.availableBeds}'.text(),
                    'Charity Funds: \$${funds.charityFunds}'.text(),
                    // 'Reputation: ${hospitalBloc.reputation}'.text(),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              admittedPatientsBloc.admittedPatients.length.text(),
              waitingPatientsBloc.waitingPatients.length.text(),
              waitingPatientsBloc.flow.text(),
              ElevatedButton(
                onPressed:
                    //  hospitalBloc.canBuyEquipment(500)
                    // ? () => hospitalBloc.buyEquipment(500)
                    // :
                    null,
                child: const Text('Buy Equipment (\$500)'),
              ).pad(),
              ElevatedButton(
                onPressed:
                    //  hospitalBloc.canBuyEquipment(500)
                    // ? () => hospitalBloc.buyEquipment(500)
                    // :
                    null,
                child: const Text('Hire Staff (\$500)'),
              ).pad(),
              // SparkBuilder(
              //   flowRepositoryRM.state.flow(),
              //   builder: (value) => value.text(),
              // ),
            ],
          ),
        ],
      ).pad(),
      floatingActionButton: const WaitingButton(),
    );
  }
}
