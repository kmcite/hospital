import 'package:hospital/main.dart';
import 'package:hospital/utils/list_view.dart';
import 'package:hospital/utils/navigator.dart';
import 'package:hospital/features/patients/patient_details_page.dart';
import 'package:hux/hux.dart';

import 'package:hospital/repositories/generation_api.dart';

import '../../models/patient.dart';

final searchQuery = signal('');
final searchedPatients = computed(
  () {
    final query = searchQuery().toLowerCase();
    if (query.isEmpty) {
      return <Patient>[];
    }
    return generationRepository.waitingPatients.values.where(
      (pt) {
        return pt.name.toLowerCase().contains(query) ||
            (pt.complaints.toLowerCase().contains(query));
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
            child: () {
              if (searchedPatients().isEmpty && searchQuery().isNotEmpty) {
                return Center(child: Text('No patients found.'));
              }
              return listView(
                searchedPatients(),
                (pt) => HuxCard(
                  title: pt.name,
                  subtitle: pt.complaints,
                  child: pt.text(),
                  onTap: () => navigator.to(PatientDetailsPage(pt)),
                ).pad(),
              );
            }(),
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
