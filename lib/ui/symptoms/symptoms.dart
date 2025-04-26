import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/main.dart';
import 'package:hospital/models/symptom.dart';
import 'package:hospital/navigator.dart';
import 'package:hospital/api/symptoms_repository.dart';
import 'package:hospital/ui/symptoms/symptoms_page.dart';

mixin SymptomUpdaterBloc {
  Symptom symptom([Symptom? value]) {
    if (value != null) {
      selectedSymptomRepository.state = value;
    }
    return selectedSymptomRepository.state;
  }

  void back() {
    navigator.back();
    symptom(Symptom());
  }

  void save() {
    navigator.back();
    symptomsRepository.put(symptom());
  }
}

class SymptomUpdaterDialog extends UI with SymptomUpdaterBloc {
  const SymptomUpdaterDialog();

  @override
  Widget build(context) {
    return FDialog(
      title: FHeader(
        title: Text(symptom().name.isEmpty ? 'New Symptom' : symptom().name),
        actions: [
          FBadge(
            label: Text(
              '\$${symptom().cost}',
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          FTextField(
            label: 'name'.text(),
            initialValue: symptom().name,
            onChange: (value) => symptom(symptom()..name = value),
          ),
          FTextField(
            label: 'description'.text(),
            initialValue: symptom().description,
            onChange: (value) => symptom(symptom()..description = value),
          ),
          FLabel(
            label: 'cost'.text(),
            axis: Axis.vertical,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FButton.icon(
                  onPress: () {
                    symptom(symptom()..cost = symptom().cost - 10);
                  },
                  child: FIcon(FAssets.icons.delete),
                ),
                Text(
                  '\$${symptom().cost}',
                ).pad(),
                FButton.icon(
                  onPress: () {
                    symptom(symptom()..cost = symptom().cost + 10);
                  },
                  child: FIcon(FAssets.icons.plus),
                ),
              ],
            ).pad(),
          ),
        ],
      ),
      direction: Axis.horizontal,
      actions: [
        FButton(
          onPress: save,
          label: Text('Save'),
        ),
        FButton(
          onPress: back,
          style: FButtonStyle.destructive,
          label: Text('Cancel'),
        ),
      ],
    );
  }
}
