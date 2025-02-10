import 'package:hospital/main.dart';

@Entity()
class Symptom {
  @Id(assignable: true)
  int id = 0;
  String description = '';
}

class SymptomsRepository with CRUD<Symptom> {
  List<String> getStringsFor() => getAll().map((_) => _.description).toList();
}

final symptomsRepository = SymptomsRepository();
