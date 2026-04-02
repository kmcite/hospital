import 'package:hospital/data/medical_data.dart';
import 'package:hospital/signals/money.dart';
import 'package:signals/signals.dart';

enum PatientStatus { waiting, treated, expired }

class Patient {
  final int id;
  final String name;
  final double maxTime;
  late final Signal<double> remainingTime;
  final MedicalCondition condition;
  late final Signal<PatientStatus> status;
  late final Signal<double> treatmentProgress;
  final givenTreatments = <String>{};
  late final List<TreatmentOption> suggestedTreatments;
  bool isDialogOpen = false;

  Patient(this.id, this.name, this.maxTime, this.condition) {
    remainingTime = signal(maxTime);
    status = signal(PatientStatus.waiting);
    treatmentProgress = signal(0.0);
    _generateSuggestions();
  }

  void _generateSuggestions() {
    // Collect all correct/helpful treatments
    final helpfulNames = condition.treatmentEffects.keys.toList();
    final helpfulOptions = allTreatments
        .where((t) => helpfulNames.contains(t.name))
        .toList();

    // Get non-helpful options
    final others = allTreatments
        .where((t) => !helpfulNames.contains(t.name))
        .toList();

    // Pick 2 from the same medical category as distractors (to make it harder/more realistic)
    final sameCategory =
        others.where((t) => t.category == condition.category).toList()
          ..shuffle();
    final completelyDifferent =
        others.where((t) => t.category != condition.category).toList()
          ..shuffle();

    final distractors = [
      ...sameCategory.take(2),
      ...completelyDifferent.take(2),
    ]..shuffle();

    // Result list: all helpful + distractors
    suggestedTreatments = [...helpfulOptions, ...distractors].toList()
      ..shuffle();
  }

  String get presentingComplaints => condition.typicalSymptoms.join(', ');

  void applyTreatment(TreatmentOption treatment) {
    if (givenTreatments.contains(treatment.name)) return;
    givenTreatments.add(treatment.name);

    // Deduct cost
    money.value -= treatment.cost;

    final effect =
        condition.treatmentEffects[treatment.name] ??
        TreatmentEffect.ineffective;

    switch (effect) {
      case TreatmentEffect.cure:
        treatmentProgress.value = 1.0;
        status.value = PatientStatus.treated;
        money.value += treatment.reward * 2.5; // Big reward for cure
        break;
      case TreatmentEffect.improve:
        treatmentProgress.value = (treatmentProgress() + 0.35).clamp(0.0, 1.0);
        remainingTime.value += 20.0; // Giving a lot more time for progress
        money.value += treatment.reward;
        if (treatmentProgress() >= 1.0) {
          status.value = PatientStatus.treated;
        }
        break;
      case TreatmentEffect.ineffective:
        remainingTime.value -= 5.0; // Ineffective wastes time
        break;
      case TreatmentEffect.worsen:
        remainingTime.value -= 15.0; // Wrong choice hurts
        break;
    }
  }
}
