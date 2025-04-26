import 'package:objectbox/objectbox.dart';

class Score {
  @Id(assignable: true)
  int id;

  int points;
  int highScore;
  int totalPatientsHealed;
  int totalPatientsDischarged;
  int totalPatientsReferred;
  double averageSatisfaction;
  int perfectTreatments; // Treatments with 100% satisfaction
  int criticalPatientsSaved; // Successfully treated critical/life-threatening patients

  Score({
    this.id = 0,
    this.points = 0,
    this.highScore = 0,
    this.totalPatientsHealed = 0,
    this.totalPatientsDischarged = 0,
    this.totalPatientsReferred = 0,
    this.averageSatisfaction = 0.0,
    this.perfectTreatments = 0,
    this.criticalPatientsSaved = 0,
  });
}
