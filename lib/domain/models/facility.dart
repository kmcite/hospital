class Facility {
  final String id;
  final String name;
  int currentLevel;
  int maxLevel;
  int upgradeCost;
  int additionalBedsPerLevel;

  Facility({
    required this.id,
    required this.name,
    this.currentLevel = 1,
    this.maxLevel = 5,
    this.upgradeCost = 1000,
    this.additionalBedsPerLevel = 5,
  });

  bool canUpgrade(int availableFunds) {
    return currentLevel < maxLevel && availableFunds >= upgradeCost;
  }

  int get totalBeds => currentLevel * additionalBedsPerLevel;

  void upgrade() {
    if (currentLevel < maxLevel) {
      currentLevel++;
      upgradeCost *= 2; // Incremental cost increase.
    }
  }
}
