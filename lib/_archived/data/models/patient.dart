import 'package:faker/faker.dart';

class Patient {
  Patient()
    : id = faker.guid.guid(),
      name = faker.person.name(),
      concern = faker.randomGenerator.element(
        List.from(
          <String>[
            ...presentingComplaints,
            ..._minorOtConcerns,
            ...complaintsRequiringNursingCare,
          ],
        ),
      ),
      fee = faker.randomGenerator.integer(500, min: 120),
      arrivedAt = DateTime.now();

  final String id;
  final String name;
  final String concern;
  final int fee;
  final DateTime arrivedAt;

  bool get requiresMinorOtCare => _minorOtConcerns.contains(concern);
  bool get requiresNursingCare =>
      complaintsRequiringNursingCare.contains(concern);
}

const presentingComplaints = [
  'Fever and body aches',
  'Chest discomfort',
  'Headache',
  'Cough and sore throat',
  'Stomach pain',
  'Follow-up consultation',
  'Blood pressure check',
];

const _minorOtConcerns = {
  'Minor wound dressing',
  'Cut injury',
  'Burn dressing',
  'Sprain support',
};

const complaintsRequiringNursingCare = {
  'IV line',
  'Injections',
};
