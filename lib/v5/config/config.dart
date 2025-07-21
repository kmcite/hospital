import 'package:flutter/material.dart';
import 'package:hospital/main.dart';
import 'package:hospital/utils/list_view.dart';
import 'package:hospital/utils/navigator.dart';
import 'package:hospital/v5/balance/balance.dart';
import 'package:hospital/v5/medications/medications.dart';

final ambulanceFees = signal(100.0);
final _clinicName = signal('Adnan');
final clinicName = computed(() => _clinicName());

final ambulanceFeesString = computed(
  () => ambulanceFees().toStringAsFixed(0),
);

final dark = signal(false);

class ConfigPage extends UI {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text('Configuration'),
        suffixes: [
          FHeaderAction(
            onPress: () => put_medication(Medication()),
            icon: Icon(FIcons.plus),
          ),
          FHeaderAction.back(onPress: navigator.back),
        ],
      ),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FButton(
            onPress: clear_balancing_history,
            child: 'Clear Balancing History'.text(),
          ),
          FSwitch(
            label: 'DARK MODE'.text(),
            description: 'toggle dark mode'.text(),
            value: dark(),
            onChange: dark.set,
          ).pad(),
          FLabel(
            axis: Axis.vertical,
            label: 'Ambulance Fees'.text(),
            description: ambulanceFeesString.text(),
            child: FButton.icon(
              style: FButtonStyle.primary(),
              onPress: () => openAmbulanceFeeModificationDialog(),
              child: 'Update'.text(),
            ),
          ),
          FTextField(
            label: 'Clinic Name'.text(),
            initialText: clinicName(),
            onChange: _clinicName.set,
          ),
          FCard(
            child: 'Total Medications: ${allMedicationsQuantity()}'.text(),
          ),
          Expanded(
            child: listView(
              medications(),
              (item) {
                return FTile(
                  title: item.name.text(),
                  subtitle: item.amount.text(),
                  onPress: () => remove_medication(item.id),
                );
              },
            ),
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

  return navigator.toDialog(
    Watch(
      (_) => FDialog(
        direction: Axis.horizontal,
        body: FSlider(
          label: 'Fees Modification'.text(),
          description: '$currentFees'.text(),
          controller: FContinuousSliderController(
            selection: FSliderSelection(
              max: _currentFees() / 1500,
              extent: (
                min: 0,
                max: 1,
              ),
            ),
          ),
          onChange: (value) {
            _currentFees.set(value.offset.max * 1500);
          },
        ),
        actions: [
          FButton.icon(
            onPress: () {
              ambulanceFees.set(_currentFees());
              navigator.back();
            },
            child: 'Ok'.text(),
          ),
          FButton.icon(
            onPress: navigator.back,
            child: 'Cancel'.text(),
          ),
        ],
      ),
    ),
  );
}
