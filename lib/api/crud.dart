import 'package:flutter/material.dart';
import 'package:hospital/api/patients_repository.dart';

class CRUD<T extends Model> extends ChangeNotifier {
  Map<int, T> _data = {};
  int get count => _data.length;
  T? getById(int id) => _data[id];
  List<T> getAll() => _data.values.toList();
  void put(T item) {
    _data[item.id] = item;
    (item as ChangeNotifier).addListener(notifyListeners);
    notifyListeners();
  }

  void remove(int id) {
    _data.remove(id);
    (getById(id) as ChangeNotifier?)?.removeListener(notifyListeners);
    notifyListeners();
  }

  void clear() {
    _data.clear();
    notifyListeners();
  }

  List<T> call([T? value]) {
    if (value != null) {
      put(value);
    }
    return getAll();
  }
}
