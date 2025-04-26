import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/api/patients_repository.dart';
import 'package:hospital/api/settings_repository.dart';
import 'package:hospital/main.dart';
import 'package:hospital/models/user.dart';

String get _name => userRepository.name;

class UserPage extends UI {
  @override
  List<Listenable> get listenables => super.listenables..add(pageController);
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: _name.text(),
        actions: [
          FButton.icon(
            child: FIcon(FAssets.icons.hospital),
            onPress: () {
              pageController.nextPage(
                duration: 400.milliseconds,
                curve: Curves.decelerate,
              );
            },
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Welcome! Ready to make a difference in healthcare today? 🌟',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          FButton(
            label: Text('RESOURCES'),
            onPress: () {},
          ).pad(all: 16),
          FButton(
            label: Text('HOSPITAL'),
            onPress: () {
              pageController.nextPage(
                duration: 400.milliseconds,
                curve: Curves.decelerate,
              );
            },
          ).pad(all: 16),
          Card.outlined(
            child: Column(
              children: [
                'total patients'.text(),
                patientsRepository().length.text(),
                Text(
                  'waiting patients ${patientsRepository.getByStatus().length}',
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
