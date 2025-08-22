// ignore_for_file: unused_local_variable

import 'package:forui/forui.dart';
import 'package:hospital/features/medications/medications.dart';
import 'package:hospital/main.dart';
import 'package:hospital/repositories/generation_api.dart';
import 'package:hospital/utils/navigator.dart';
import 'package:hux/hux.dart';

import '../../repositories/patients_api.dart';
import '../../repositories/settings_api.dart';

final _clinicName = signal('HOSPITAL');
final clinicName = computed(() => _clinicName());

final ambulanceFeesString = computed(
  () => ambulanceFees().toStringAsFixed(0),
);

final focusNode = FocusNode();

class SettingsPage extends UI {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text('Settings'),
        suffixes: [
          FHeaderAction(
            icon: Icon(FeatherIcons.arrowLeftCircle),
            onPress: () => navigator.back(),
          ),
        ],
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          IconButton(
            icon: Icon(FeatherIcons.moon),
            onPressed: () => settingsRepository.toggleDark(),
          ),
          IconButton(
            onPressed: openAmbulanceFeeModificationDialog,
            icon: Icon(FeatherIcons.edit),
          ),
          IconButton(
            onPressed: () {
              generationRepository.unsatisfiedPatients.clear();
            },
            icon: Icon(FeatherIcons.trash),
          ),
          IconButton(
            onPressed: () => navigator.to(MedicationsPage()),
            icon: Icon(FeatherIcons.hexagon),
          ),
          FTextField(
            initialText: clinicName(),
            onChange: _clinicName.set,
          ),
        ],
      ),
    );
  }
}

Future<void> openAmbulanceFeeModificationDialog() {
  final _currentFees = signal(ambulanceFees());
  final currentFees = computed(
    () => _currentFees().toStringAsFixed(0),
  );
  final controller = TextEditingController()..text = currentFees();

  return navigator.toDialog(
    Watch(
      (_) => Dialog(
        child: Column(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            HuxCard(
              title: 'Enter New Fee',
              subtitle: currentFees(),
              child: HuxInput(
                controller: controller,
                keyboardType: TextInputType.number,
                onChanged: (val) => _currentFees.set(double.tryParse(val) ?? 0),
              ),
            ),
            Row(
              spacing: 8,
              children: [
                HuxButton(
                  onPressed: () {
                    ambulanceFees.set(_currentFees());
                    navigator.back();
                  },
                  child: 'Ok'.text(),
                ),
                HuxButton(
                  onPressed: navigator.back,
                  child: 'Cancel'.text(),
                ),
              ],
            ),
          ],
        ).pad(all: 16),
      ),
    ),
  );
}
