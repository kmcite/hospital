import 'package:hospital/main.dart';
import 'package:hospital/objectbox.g.dart';
import '../models/medication.dart';

class MedicationsRepository extends Repository {
  late final Box<Medication> _medicationsBox;

  MedicationsRepository() {
    final store = find<Store>();
    _medicationsBox = store.box<Medication>();
  }

  int get length => _medicationsBox.count();

  Iterable<Medication> get medications => _medicationsBox.getAll();

  void putMedication(Medication medication) {
    _medicationsBox.put(medication);
  }

  void removeMedication(Medication medication) {
    _medicationsBox.remove(medication.id);
  }

  void removeMedicationById(int id) {
    _medicationsBox.remove(id);
  }

  Medication? getMedication(int id) {
    return _medicationsBox.get(id);
  }

  List<Medication> searchMedications(String query) {
    if (query.isEmpty) return _medicationsBox.getAll();

    return _medicationsBox
        .getAll()
        .where((med) =>
            med.name.toLowerCase().contains(query.toLowerCase()) ||
            med.medicationId.toLowerCase().contains(query.toLowerCase()) ||
            med.manufacturer.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  List<Medication> getLowStockMedications() {
    return _medicationsBox.getAll().where((med) => med.isLowStock).toList();
  }

  List<Medication> getExpiredMedications() {
    return _medicationsBox.getAll().where((med) => med.isExpired).toList();
  }

  List<Medication> getAvailableMedications() {
    return _medicationsBox.getAll().where((med) => med.isAvailable).toList();
  }

  void updateMedicationStock(int medicationId, int newStock) {
    final medication = _medicationsBox.get(medicationId);
    if (medication != null) {
      medication.updateStock(newStock);
      _medicationsBox.put(medication);
    }
  }
}

// Global instance
final medicationsRepository = MedicationsRepository();
