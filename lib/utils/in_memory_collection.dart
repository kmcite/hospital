import 'package:hospital/utils/collection.dart';
import 'package:hospital/utils/model.dart';

class InMemoryCollection<T extends Model> extends Collection<T> {
  final items = <int, T>{};

  @override
  int get length => items.length;

  @override
  void put(T item) {
    items[item.id] = item;
    notifyListeners();
  }

  @override
  T? get(int id) {
    return items[id];
  }

  @override
  bool contains(int id) {
    return items.containsKey(id);
  }

  @override
  void remove(int id) {
    items.remove(id);
    notifyListeners();
  }

  @override
  void removeAll() {
    items.clear();
    notifyListeners();
  }

  @override
  List<T> getAll() {
    return items.values.toList();
  }
}
