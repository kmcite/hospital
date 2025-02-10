class Facility {
  final String name;
  int currentLevel;
  int maxLevel;
  double upgradeCost;
  int additionalBedsPerLevel;

  Facility({
    required this.name,
    this.currentLevel = 1,
    this.maxLevel = 5,
    this.upgradeCost = 1000,
    this.additionalBedsPerLevel = 5,
  });

  bool canUpgrade(double availableFunds) {
    return currentLevel < maxLevel && availableFunds >= upgradeCost;
  }

  int get totalBeds => currentLevel * additionalBedsPerLevel;

  void upgrade() {
    if (currentLevel < maxLevel) {
      currentLevel++;
      upgradeCost *= 1.5; // Incremental cost increase.
    }
  }
}
