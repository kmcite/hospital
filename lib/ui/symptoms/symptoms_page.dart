import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/main.dart';
import 'package:hospital/models/symptom.dart';
import 'package:hospital/navigator.dart';
import 'package:hospital/api/symptoms_repository.dart';
import 'symptoms.dart';

final selectedSymptomRepository = RM.inject(() => Symptom());

mixin SymptomsBloc {
  Injected<Symptom> get symptom => selectedSymptomRepository;
  CollectionModifier<Symptom> get symptoms => symptomsRepository;
}

// ignore: must_be_immutable
class SymptomsPage extends UI with SymptomsBloc {
  @override
  Widget build(context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text('Symptoms'),
        prefixActions: [
          FButton.icon(
            onPress: navigator.back,
            child: FIcon(FAssets.icons.arrowLeft),
          ),
        ],
        suffixActions: [
          FButton.icon(
            onPress: () {
              symptom.state = Symptom();
              navigator.toDialog(const SymptomUpdaterDialog());
            },
            child: FIcon(FAssets.icons.plus),
          ),
        ],
      ),
      content: ListView.builder(
        itemCount: symptomsRepository.getAll().length,
        itemBuilder: (context, index) {
          final _symptom = symptoms().elementAt(index);
          return FTile(
            title: Text(_symptom.name),
            subtitle: Text(_symptom.description),
            suffixIcon: FBadge(
              label: Text('\$${_symptom.cost}'),
            ),
            onPress: () {
              symptom.state = (_symptom);
              navigator.toDialog(const SymptomUpdaterDialog());
            },
          );
        },
      ),
    );
  }
}
