// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:hospital/main.dart';
import 'package:hospital/repositories/generation_api.dart';
import 'package:hospital/utils/list_view.dart';
import 'package:hospital/utils/navigator.dart';
import 'package:hospital/repositories/medications_api.dart';
import 'package:hux/hux.dart';

import '../../repositories/ambulance_fees_api.dart';
import '../../models/medication.dart';
import '../../repositories/settings_api.dart';

final _clinicName = signal('HOSPITAL');
final clinicName = computed(() => _clinicName());

final ambulanceFeesString = computed(
  () => ambulanceFees().toStringAsFixed(0),
);

final focusNode = FocusNode();

final controller = TextEditingController()..text = clinicName();

class SettingsPage extends UI {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            icon: Icon(FeatherIcons.plus),
            onPressed: () => medicationsRepository.putMedication(Medication()),
          ).pad(),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HuxButton(
            child: 'Dark Mode'.text(),
            onPressed: () => settingsRepository.toggleDark(),
          ).pad(),
          HuxCard(
            title: 'Ambulance Fees',
            child: HuxButton(
              onPressed: null,
              child: ambulanceFeesString().text(),
            ),
            onTap: () => openAmbulanceFeeModificationDialog(),
          ).pad(),
          HuxCard(
            title: 'Clear Unsatisfied List',
            child: HuxButton(
              onPressed: () => generationRepository.unsatisfiedPatients.clear(),
              child: 'Clear'.text(),
            ),
          ).pad(),
          HuxTextField(
            controller: controller,
            onChanged: _clinicName.set,
          ).pad(),
          ListTile(
            title: Text(
              'Medications: ${medicationsRepository.length()}',
            ),
          ),
          Expanded(
            child: listView(
              medicationsRepository.medications(),
              (item) {
                return HuxCard(
                  title: item.name,
                  subtitle: item.amount.toString(),
                  onTap: () => medicationsRepository.removeMedication(item),
                  child: item.text(),
                ).pad();
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
              child: HuxTextField(
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
