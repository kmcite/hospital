import 'package:hospital/models/reception.dart';
import 'package:objectbox/objectbox.dart';

import '../main.dart';

class ReceptionsRepository extends Repository {
  final store = find<Store>();
  late final box = store.box<Reception>();

  /// READ
  Iterable<Reception> getAll() => box.getAll();
  Reception? get(int mr) => box.get(mr);

  /// WRITE
  Reception? remove(int mr) {
    final reception = box.get(mr);
    box.remove(mr);
    return reception;
  }

  void clear() {
    box.removeAll();
  }

  void put(Reception reception) {
    box.put(reception);
  }
}
