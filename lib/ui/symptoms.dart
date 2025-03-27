import 'package:flutter/material.dart';
import 'package:hospital/domain/api/symptoms_repository.dart';
import 'package:hospital/domain/models/symptom.dart';
import 'package:hospital/main.dart';
import 'package:hospital/navigator.dart';
import 'package:hospital/utils/api.dart';

final _symptomRepository = signal(Symptom());

class SymptomsPage extends UI with SymptomUpdaterX {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Symptoms'.text(),
      ),
      body: ListView.builder(
        itemCount: symptomsRepository.getAll().length,
        itemBuilder: (context, index) {
          final _symptom = symptomsRepository.getAll().elementAt(index);
          return ListTile(
            title: _symptom.name.text(),
            subtitle: _symptom.description.text(),
            trailing: _symptom.cost.text(),
            onTap: () {
              symptom(_symptom);
              navigator.toDialog(SymptomUpdaterDialog());
            },
          );
        },
      ),
    );
  }
}

mixin SymptomUpdaterX {
  Modifier<Symptom> get symptom => _symptomRepository;

  void back() {
    navigator.back();
    _symptomRepository(Symptom());
  }

  void save() {
    symptomsRepository.put(symptom());
    navigator.back();
    _symptomRepository(Symptom());
  }
}

class SymptomUpdaterDialog extends UI with SymptomUpdaterX {
  const SymptomUpdaterDialog();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: navigator.back, icon: Icon(Icons.arrow_back)),
              symptom().name.text().pad(),
              CircleAvatar(
                child: symptom().cost.text(),
              ),
            ],
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'name',
            ),
            initialValue: symptom().name,
            onChanged: (value) {
              symptom(symptom()..name = value);
            },
          ).pad(),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'description',
            ),
            initialValue: symptom().description,
            onChanged: (value) {
              symptom(symptom()..description = value);
            },
          ).pad(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  symptom(symptom()..cost = symptom().cost + 10);
                },
                icon: Icon(Icons.add),
              ),
              IconButton(
                onPressed: () {
                  symptom(symptom()..cost = symptom().cost - 10);
                },
                icon: Icon(Icons.crop_sharp),
              ),
            ],
          ),
          FilledButton(
            onPressed: save,
            child: 'save'.text(),
          ).pad(),
        ],
      ).pad(),
    );
  }
}
