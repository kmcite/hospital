// import 'dart:async';

// import 'package:hospital/utils/collection.dart';
// import 'package:hospital/utils/model.dart';
// import 'package:hospital/utils/locator.dart';
// // import 'package:objectbox/objectbox.dart';

// class CrudCollection<T extends Model> extends Collection<T> {
//   StreamSubscription<List<T>>? _subscription;
//   CrudCollection() {
//     /// a local subscription so to maintain locally the items from the db
//     _subscription = watch().listen((items) {
//       this.items = items;
//       notifyListeners(); // notify every change through change notifier
//     });
//   }
//   Stream<List<T>> watch() => box.query().watch(triggerImmediately: true).map(
//         (query) => query.find(),
//       );

//   late final store = serve<Store>();
//   late final box = store.box<T>();

//   /// pointer to local items from db.
//   late List<T> items = getAll();

//   @override
//   int get length => items.length;

//   @override
//   T? get(int id) => box.get(id);

//   @override
//   void put(T entity) {
//     box.put(entity);
//   }

//   @override
//   void removeAll() {
//     box.removeAll();
//   }

//   @override
//   List<T> getAll() {
//     return box.getAll();
//   }

//   @override
//   void remove(int id) {
//     box.remove(id);
//   }

//   @override
//   bool contains(int id) {
//     return box.contains(id);
//   }
// }
