import 'package:hospital/hospital/resources/resources.dart';

class Upgrade {
  String name = "Unknown";
  int cost = 1000;
  int benefit = 5; // e.g., +5 beds or +5% efficiency
  bool isPurchased = false;

  void purchase(Resources resources) {
    if (!isPurchased && resources.canAfford(cost)) {
      resources.deductFunds(cost);
      isPurchased = true;
    }
  }
}

class UpgradeSystem {
  List<Upgrade> availableUpgrades = [];

  void addUpgrade(Upgrade upgrade) {
    availableUpgrades.add(upgrade);
  }

  void applyUpgrade(Upgrade upgrade, Resources resources) {
    if (upgrade.isPurchased) {
      if (upgrade.name == "Bed Expansion")
        resources.availableBeds += upgrade.benefit;
      if (upgrade.name == "Staff Hiring")
        resources.staffCount += upgrade.benefit;
    }
  }
}
