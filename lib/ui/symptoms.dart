import 'package:flutter/material.dart';
import 'package:hospital/domain/models/symptom.dart';
import 'package:hospital/main.dart';
import 'package:hospital/navigator.dart';

final _symptomRepository = RM.inject(() => Symptom());

class SymptomsPage extends UI with SymptomUpdaterX {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Symptoms'.text(),
      ),
      // body: ListView.builder(
      //   itemCount: symptomsRepository.getAll().length,
      //   itemBuilder: (context, index) {
      //     final _symptom = symptomsRepository.getAll().elementAt(index);
      //     return ListTile(
      //       title: _symptom.name.text(),
      //       subtitle: _symptom.description.text(),
      //       trailing: _symptom.cost.text(),
      //       onTap: () {
      //         symptom(_symptom);
      //         navigator.toDialog(SymptomUpdaterDialog());
      //       },
      //     );
      //   },
      // ),
    );
  }
}

mixin SymptomUpdaterX {
  Injected<Symptom> get symptom => _symptomRepository;

  void back() {
    navigator.back();
    _symptomRepository.state = (Symptom());
  }

  void save() {
    navigator.back();
    _symptomRepository.state = (symptom.state);
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
              symptom.state.name.text().pad(),
              CircleAvatar(
                child: symptom.state.cost.text(),
              ),
            ],
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'name',
            ),
            initialValue: symptom.state.name,
            onChanged: (value) {
              symptom.state = (symptom.state..name = value);
            },
          ).pad(),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'description',
            ),
            initialValue: symptom.state.description,
            onChanged: (value) {
              symptom.state = (symptom.state..description = value);
            },
          ).pad(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () => symptom.state =
                    (symptom.state..cost = symptom.state.cost + 10),
                icon: Icon(Icons.add),
              ),
              IconButton(
                onPressed: () {
                  symptom.state =
                      (symptom.state..cost = symptom.state.cost - 10);
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
