enum TreatmentEffect { cure, improve, ineffective, worsen }

class TreatmentOption {
  final String name;
  final double cost;
  final double reward;
  final String category; // e.g., 'Respiratory', 'Pain', 'Hydration', etc.

  const TreatmentOption({
    required this.name,
    required this.category,
    this.cost = 0.0,
    this.reward = 10.0,
  });
}

class MedicalCondition {
  final String name;
  final List<String> typicalSymptoms;
  final Map<String, TreatmentEffect> treatmentEffects;
  final String category;

  const MedicalCondition({
    required this.name,
    required this.typicalSymptoms,
    required this.treatmentEffects,
    required this.category,
  });
}

const List<TreatmentOption> allTreatments = [
  TreatmentOption(name: 'Advise Rest', category: 'General', cost: 0, reward: 5),
  TreatmentOption(name: 'Paracetamol', category: 'Pain', cost: 2, reward: 15),
  TreatmentOption(name: 'Ibuprofen', category: 'Pain', cost: 3, reward: 15),
  TreatmentOption(
    name: 'Amoxicillin (Antibiotic)',
    category: 'Respiratory',
    cost: 10,
    reward: 40,
  ),
  TreatmentOption(
    name: 'IV Saline',
    category: 'Hydration',
    cost: 15,
    reward: 50,
  ),
  TreatmentOption(
    name: 'Oral Rehydration Salt',
    category: 'Hydration',
    cost: 5,
    reward: 20,
  ),
  TreatmentOption(
    name: 'Antihistamine',
    category: 'Allergy',
    cost: 5,
    reward: 20,
  ),
  TreatmentOption(
    name: 'Cool Compress',
    category: 'General',
    cost: 0,
    reward: 10,
  ),
  TreatmentOption(
    name: 'Vicks Vaporub',
    category: 'Respiratory',
    cost: 5,
    reward: 15,
  ),
  TreatmentOption(
    name: 'Insulin Shot',
    category: 'Diabetes',
    cost: 20,
    reward: 60,
  ),
  TreatmentOption(
    name: 'Inhaler (Salbutamol)',
    category: 'Respiratory',
    cost: 12,
    reward: 45,
  ),
  TreatmentOption(
    name: 'Betadine Cream',
    category: 'Topical',
    cost: 4,
    reward: 15,
  ),
  TreatmentOption(
    name: 'Cough Syrup',
    category: 'Respiratory',
    cost: 6,
    reward: 20,
  ),
  TreatmentOption(name: 'Antacid', category: 'Digestive', cost: 4, reward: 15),
  TreatmentOption(
    name: 'Loperamide',
    category: 'Digestive',
    cost: 5,
    reward: 20,
  ),
  TreatmentOption(name: 'Eye Drops', category: 'Ocular', cost: 8, reward: 25),
  TreatmentOption(name: 'Ear Drops', category: 'Ocular', cost: 7, reward: 22),
  TreatmentOption(
    name: 'Blood Pressure Meds',
    category: 'Cardiovascular',
    cost: 15,
    reward: 50,
  ),
];

const List<MedicalCondition> allConditions = [
  MedicalCondition(
    name: 'Common Cold',
    category: 'Respiratory',
    typicalSymptoms: ['Runny nose', 'Stuffy nose', 'Sneezing', 'Sore throat'],
    treatmentEffects: {
      'Advise Rest': TreatmentEffect.improve,
      'Paracetamol': TreatmentEffect.improve,
      'Cough Syrup': TreatmentEffect.improve,
      'Vicks Vaporub': TreatmentEffect.cure,
    },
  ),
  MedicalCondition(
    name: 'Bacterial Infection',
    category: 'Respiratory',
    typicalSymptoms: ['Fever', 'Chills', 'Sore throat'],
    treatmentEffects: {
      'Amoxicillin (Antibiotic)': TreatmentEffect.cure,
      'Paracetamol': TreatmentEffect.improve,
    },
  ),
  MedicalCondition(
    name: 'Dehydration',
    category: 'Hydration',
    typicalSymptoms: ['Dizziness', 'Fatigue', 'Dry skin'],
    treatmentEffects: {
      'IV Saline': TreatmentEffect.cure,
      'Oral Rehydration Salt': TreatmentEffect.improve,
    },
  ),
  MedicalCondition(
    name: 'Hay Fever',
    category: 'Allergy',
    typicalSymptoms: ['Runny nose', 'Sneezing', 'Itching'],
    treatmentEffects: {
      'Antihistamine': TreatmentEffect.cure,
      'Eye Drops': TreatmentEffect.improve,
    },
  ),
  MedicalCondition(
    name: 'Heat Stroke',
    category: 'General',
    typicalSymptoms: ['Fever', 'Confusion', 'Dizziness'],
    treatmentEffects: {
      'Cool Compress': TreatmentEffect.improve,
      'IV Saline': TreatmentEffect.cure,
    },
  ),
  MedicalCondition(
    name: 'Asthma Attack',
    category: 'Respiratory',
    typicalSymptoms: ['Shortness of breath', 'Chest pain', 'Cough'],
    treatmentEffects: {
      'Inhaler (Salbutamol)': TreatmentEffect.cure,
      'Advise Rest': TreatmentEffect.worsen,
    },
  ),
  MedicalCondition(
    name: 'Food Poisoning',
    category: 'Digestive',
    typicalSymptoms: ['Nausea', 'Vomiting', 'Diarrhea', 'Abdominal pain'],
    treatmentEffects: {
      'Oral Rehydration Salt': TreatmentEffect.improve,
      'Loperamide': TreatmentEffect.improve,
      'IV Saline': TreatmentEffect.cure,
    },
  ),
  MedicalCondition(
    name: 'Gastritis',
    category: 'Digestive',
    typicalSymptoms: ['Abdominal pain', 'Heartburn', 'Nausea'],
    treatmentEffects: {
      'Antacid': TreatmentEffect.cure,
      'Paracetamol': TreatmentEffect.worsen,
    },
  ),
  MedicalCondition(
    name: 'Hypoglycemia',
    category: 'Diabetes',
    typicalSymptoms: ['Dizziness', 'Confusion', 'Fatigue', 'Tremors'],
    treatmentEffects: {
      'Oral Rehydration Salt': TreatmentEffect.improve,
      'IV Saline': TreatmentEffect.improve,
      'Advise Rest': TreatmentEffect.worsen,
    },
  ),
  MedicalCondition(
    name: 'Hypertension',
    category: 'Cardiovascular',
    typicalSymptoms: ['Headache', 'Dizziness', 'Palpitations'],
    treatmentEffects: {
      'Blood Pressure Meds': TreatmentEffect.cure,
      'Advise Rest': TreatmentEffect.improve,
    },
  ),
];
