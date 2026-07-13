import 'package:hospital/apis/events.dart';
import 'package:hospital/utils/messaging.dart';
import 'package:signals/signals.dart';

class DarkRead {
  final darkSignal = signal(true, debugLabel: 'DARK_MODE');
  DarkRead() {
    listen<DarkToggled>((e) => darkSignal.toggle());
  }
}

final darkRead = DarkRead();
