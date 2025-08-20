import 'package:flutter/material.dart';
import 'package:hospital/main.dart';
import 'package:hospital/utils/list_view.dart';
import 'package:hospital/utils/navigator.dart';
import 'package:hospital/features/patients/patient_details_page.dart';
import 'package:hux/hux.dart';

import '../../repositories/patients_api.dart';

final searchQuery = signal('');
final searchedPatients = computed(
  () {
    return managedPatients.values.where(
      (pt) {
        return pt.name.contains(
          searchQuery(),
        );
      },
    );
  },
);

Widget searchPatients() {
  return GUI(
    () {
      return Column(
        children: [
          searchBar(),
          Expanded(
            child: listView(
              searchedPatients(),
              (pt) => HuxCard(
                title: pt.name,
                subtitle: pt.complaints,
                child: pt.text(),
                onTap: () => navigator.to(patientDetailsPage(pt)),
              ).pad(),
            ),
          ),
        ],
      );
    },
  );
}

Widget searchBar() {
  return TextFormField(
    initialValue: searchQuery(),
    decoration: InputDecoration(
      hintText: "Search for patients",
      prefixIcon: Icon(FeatherIcons.search).pad(left: 4),
    ),
    onChanged: searchQuery.set,
  ).pad();
}
