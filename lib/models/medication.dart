import 'package:objectbox/objectbox.dart';
import 'package:hospital/main.dart';

@Entity()
class Medication {
  @Id()
  int id = 0;

  String medicationId = '';
  String name = '';
  int amount = 10;
  String dosage = '';
  String frequency = '';
  String unit = 'mg';
  double cost = 0.0;
  String instructions = '';

  // Stock management
  int stockQuantity = 0;
  int minimumStock = 5;
  @Property(type: PropertyType.date)
  DateTime? expiryDate;

  // Manufacturing details
  String manufacturer = '';
  String batchNumber = '';

  Medication() {
    medicationId = 'MED${faker.randomGenerator.integer(99999, min: 10000)}';
    name = faker.conference.name();
    manufacturer = faker.company.name();
    batchNumber = 'B${faker.randomGenerator.integer(9999, min: 1000)}';
    dosage = '${faker.randomGenerator.integer(500, min: 10)}';
    frequency = [
      'Once daily',
      'Twice daily',
      'Three times daily',
      'As needed'
    ][faker.randomGenerator.integer(4)];
    unit =
        ['mg', 'ml', 'tablets', 'capsules'][faker.randomGenerator.integer(4)];
    cost = faker.randomGenerator.decimal(scale: 100, min: 5);
    stockQuantity = faker.randomGenerator.integer(100, min: 10);
    instructions = 'Take ${frequency.toLowerCase()} ${dosage}$unit';
  }

  Medication.create({
    required this.name,
    required this.dosage,
    required this.frequency,
    this.unit = 'mg',
    this.cost = 0.0,
    this.stockQuantity = 0,
    this.instructions = '',
  }) {
    medicationId = 'MED${faker.randomGenerator.integer(99999, min: 10000)}';
    manufacturer = faker.company.name();
    batchNumber = 'B${faker.randomGenerator.integer(9999, min: 1000)}';
    if (instructions.isEmpty) {
      instructions = 'Take ${frequency.toLowerCase()} ${dosage}$unit';
    }
  }

  // Business methods
  bool get isLowStock => stockQuantity <= minimumStock;
  bool get isExpired =>
      expiryDate != null && expiryDate!.isBefore(DateTime.now());
  bool get isAvailable => stockQuantity > 0 && !isExpired;

  void updateStock(int quantity) {
    stockQuantity = quantity;
  }

  void reduceStock(int quantity) {
    if (stockQuantity >= quantity) {
      stockQuantity -= quantity;
    }
  }

  @override
  String toString() {
    return 'Medication: $name ($dosage$unit) - Stock: $stockQuantity';
  }
}
