// import 'package:forui/forui.dart'; // Removed - using Material Design
import 'package:hospital/main.dart';
import 'package:hospital/utils/list_view.dart';
import 'package:hospital/features/patients/patient_details_page.dart';
// import 'package:hux/hux.dart'; // Already imported through main.dart

import 'package:hospital/repositories/generation_api.dart';

import '../../models/patient.dart';

class SearchPatientsBloc extends Bloc {
  late final GenerationRepository generationRepository = watch();
  String searchQuery = '';

  Iterable<Patient> get searchedPatients {
    final query = searchQuery.toLowerCase();
    if (query.isEmpty) {
      return <Patient>[];
    }
    return generationRepository.waitingPatients.values.where(
      (pt) {
        return pt.name.toLowerCase().contains(query) ||
            (pt.complaints.toLowerCase().contains(query));
      },
    );
  }

  void search(String query) {
    searchQuery = query;
    notifyListeners();
  }
}

class SearchPatients extends Feature<SearchPatientsBloc> {
  @override
  SearchPatientsBloc create() => SearchPatientsBloc();
  @override
  Widget build(context, controller) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search for patients',
              border: OutlineInputBorder(),
            ),
            onChanged: controller.search,
          ),
        ),
        Expanded(
          child: () {
            if (controller.searchedPatients.isEmpty &&
                controller.searchQuery.isNotEmpty) {
              return Center(child: Text('No patients found.'));
            }
            return listView(
              controller.searchedPatients,
              (pt) => Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text(pt.name),
                    subtitle: Text(pt.complaints),
                    onTap: () => navigator.to(PatientDetailsPage(pt)),
                  ),
                ),
              ),
            );
          }(),
        ),
      ],
    );
  }
}
