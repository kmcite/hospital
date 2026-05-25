import 'dart:async';

import 'package:hospital/api/receptionist.dart';

class ReceptionistsRepository {
  /// INTERNALS
  final _cache = <String, Receptionist>{};
  final _controller = StreamController<Iterable<Receptionist>>.broadcast();
  void _pushUpdates() {
    _controller.add(_cache.values);
  }

  /// PUBLIC API
  Stream<Iterable<Receptionist>> get watchReceptionists => _controller.stream;
  void put(Receptionist receptionist) {
    _cache[receptionist.id] = receptionist;
    _pushUpdates();
  }

  void remove(String key) {
    _cache.remove(key);
    _pushUpdates();
  }
}
