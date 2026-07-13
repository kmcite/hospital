enum DayPhase {
  day,
  night,
}

final class ClockModel {
  const ClockModel({
    this.totalHours = 0,
  });

  final int totalHours;

  int get day => totalHours ~/ 24;
  int get hour => totalHours % 24;

  int get years => day ~/ 360;
  int get months => (day % 360) ~/ 30;
  int get days => day % 30;

  DayPhase get phase {
    if (hour >= 6 && hour < 18) {
      return DayPhase.day;
    }

    return DayPhase.night;
  }

  String get phaseText {
    return phase == DayPhase.day ? 'Day' : 'Night';
  }

  String get timeText {
    final h = hour.toString().padLeft(2, '0');
    return '$h:00';
  }

  String get ageText {
    return '$years years, $months months, $days days';
  }

  ClockModel advance({
    int hours = 1,
  }) {
    return ClockModel(
      totalHours: totalHours + hours,
    );
  }
}
