import 'package:flutter/material.dart';

import '../models/patient.dart';
import '../models/score.dart';
import 'package:hospital/main.dart';

final scoreRepository = ScoreRepository();

class ScoreRepository extends ChangeNotifier {
  Map<int, Score> _scores = {};

  void put(Score) {
    _scores[Score.id] = Score;
    notifyListeners();
  }

  Score? get(int id) => _scores[id];
  Iterable<Score> getAll() => _scores.values;

  final _scoreRM = RM.inject(() => Score());
  Score get current => _scoreRM.state;

  void addPoints(int points) {
    final score = current;
    score.points += points;
    if (score.points > score.highScore) {
      score.highScore = score.points;
    }
    put(score);
    _scoreRM.notify();
  }

  void onPatientTreated(Patient patient) {
    final score = current;
    int points = 0;

    // Base points for treating a patient
    points += 10;

    // Bonus points based on urgency
    switch (patient.urgency) {
      case Urgency.lifeThreatening:
        points += 50;
        score.criticalPatientsSaved++;
        break;
      case Urgency.critical:
        points += 30;
        score.criticalPatientsSaved++;
        break;
      case Urgency.stable:
        points += 10;
        break;
    }

    // Bonus points for satisfaction
    if (patient.satisfaction >= 100) {
      points += 25;
      score.perfectTreatments++;
    } else if (patient.satisfaction >= 80) {
      points += 15;
    } else if (patient.satisfaction >= 60) {
      points += 10;
    }

    // // Time bonus (faster treatment = more points)
    // if (patient.remainingTime > 0) {
    //   points += (patient.remainingTime / patient.admissionTime * 20).round();
    // }

    // Payment bonus
    if (patient.canPay) {
      points += 5;
    }

    // Update statistics
    switch (patient.status) {
      case Status.discharged:
        score.totalPatientsDischarged++;
        score.totalPatientsHealed++;
        break;
      case Status.referred:
        score.totalPatientsReferred++;
        break;
      default:
        break;
    }

    // Update average satisfaction
    final totalPatients =
        score.totalPatientsDischarged + score.totalPatientsReferred;
    score.averageSatisfaction =
        ((score.averageSatisfaction * (totalPatients - 1)) +
                patient.satisfaction) /
            totalPatients;

    addPoints(points);
  }

  void resetScore() {
    final highScore = current.highScore;
    _scoreRM.state = Score(highScore: highScore);
    put(_scoreRM.state);
  }
}
