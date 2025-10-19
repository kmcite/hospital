import 'package:objectbox/objectbox.dart';

abstract class CrudRepository<T> {
  Store get store;
  late final box = store.box<T>();
  T? get(int id) => box.get(id);

  Future<List<T>> getAll() async => await box.getAllAsync();

  Future<void> put(T entity) async {
    await box.putAsync(entity);
  }

  Future<void> remove(int id) async {
    await box.removeAsync(id);
  }

  Future<void> removeAll() async {
    await box.removeAllAsync();
  }
}
