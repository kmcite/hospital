import 'package:faker/faker.dart';
import 'package:hospital/domain/models/symptom.dart';
import 'package:hospital/main.dart';

final symptomsRepository = SymptomsRepository();

// @dao
// abstract
class SymptomsRepository with CRUD<Symptom> {
  // @Query('SELECT * FROM Symptom WHERE id = :id')
  // Future<Symptom?> get(int id);
  // @Query('SELECT * FROM Symptom')
  // Future<List<Symptom>> getAll();
  // @Query('SELECT * FROM Symptom WHERE name = :name')
  // Future<Symptom?> getByName(String name);
  // @insert
  // Future<void> insertSymptom(Symptom symptom);

  // @update
  // Future<void> updateSymptom(Symptom symptom);

  // ignore: unused_element
  void initialize() {
    for (var sym in _getAll()) {
      put(
        Symptom()
          ..name = sym
          ..cost = random.integer(50, min: 20),
      );
    }
  }

  List<String> _getAll() {
    return [
      // General Symptoms
      "Fever",
      "Chills",
      "Fatigue",
      "Weight loss",
      "Weight gain",
      "Night sweats",
      "Malaise",
      "Weakness",

      // Neurological Symptoms
      "Headache",
      "Dizziness",
      "Seizures",
      "Loss of consciousness",
      "Confusion",
      "Tingling (Paresthesia)",
      "Numbness",
      "Difficulty speaking (Dysarthria)",
      "Blurred vision",
      "Double vision (Diplopia)",
      "Unsteady gait (Ataxia)",
      "Tremors",
      "Memory loss",

      // Cardiovascular Symptoms
      "Chest pain",
      "Palpitations",
      "Shortness of breath (Dyspnea)",
      "Syncope (Fainting)",
      "Edema (Swelling in legs)",
      "Cold extremities",
      "Cyanosis (Bluish discoloration)",

      // Respiratory Symptoms
      "Cough",
      "Hemoptysis (Coughing blood)",
      "Wheezing",
      "Stridor",
      "Chest tightness",
      "Snoring",
      "Difficulty breathing (Dyspnea)",

      // Gastrointestinal Symptoms
      "Nausea",
      "Vomiting",
      "Diarrhea",
      "Constipation",
      "Abdominal pain",
      "Blood in stool (Hematochezia/Melena)",
      "Jaundice",
      "Difficulty swallowing (Dysphagia)",
      "Bloating",
      "Loss of appetite",

      // Genitourinary Symptoms
      "Dysuria (Painful urination)",
      "Hematuria (Blood in urine)",
      "Urgency to urinate",
      "Incontinence",
      "Flank pain",
      "Testicular pain",
      "Pelvic pain",
      "Vaginal bleeding",
      "Abnormal vaginal discharge",

      // Musculoskeletal Symptoms
      "Joint pain",
      "Muscle pain",
      "Swelling in joints",
      "Stiffness",
      "Back pain",
      "Fractures",
      "Limb weakness",

      // Skin Symptoms
      "Rash",
      "Itching",
      "Swelling (Angioedema)",
      "Redness (Erythema)",
      "Bruising",
      "Ulcers",
      "Burns",
      "Blisters",
      "Dry skin",
      "Skin peeling",

      // Psychiatric Symptoms
      "Anxiety",
      "Depression",
      "Hallucinations",
      "Paranoia",
      "Aggression",
      "Insomnia",
      "Suicidal thoughts",

      // ENT Symptoms
      "Ear pain",
      "Ear discharge",
      "Hearing loss",
      "Tinnitus (Ringing in ears)",
      "Nasal congestion",
      "Nosebleed (Epistaxis)",
      "Sore throat",
      "Hoarseness",
      "Difficulty swallowing (Dysphagia)",

      // Ophthalmic Symptoms
      "Eye pain",
      "Red eyes",
      "Discharge from eyes",
      "Photophobia (Light sensitivity)",
      "Vision loss",
      "Flashing lights or floaters",
    ];
  }
}
