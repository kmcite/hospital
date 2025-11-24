import 'package:flutter/foundation.dart';
import 'package:hospital/utils/model.dart';

abstract class Collection<T extends Model> extends ChangeNotifier {
  Collection();
  int get length;
  List<T> getAll();
  void put(T entity);
  void remove(int id);
  void removeAll();
  T? get(int id);
  bool contains(int id);
}
