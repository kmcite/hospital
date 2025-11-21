import 'package:hospital/main.dart';

extension Context on BuildContext {
  T of<T>() {
    try {
      return watch<T>();
    } catch (e) {
      return read<T>();
    }
  }
}

/// super.context is necessary in every notifier
/// used for dependency injection
// abstract class Notifier extends ChangeNotifier {}

class Notifier<T> with ChangeNotifier {
  final BuildContext context;
  Notifier(this.context);
  // final controller = StreamController<T>.broadcast();
  // void put(T any) {
  //   controller.add(any);
  //   notifyListeners();
  // }

  // Stream<T> get stream => controller.stream;
}
