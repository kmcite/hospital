import 'package:hospital/domain/api/resources.dart';
import 'package:hospital/domain/models/upgrade.dart';

final upgradesRepository = UpgradeSystem();

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
