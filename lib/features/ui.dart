// import 'package:flutter/foundation.dart' show ValueListenable;
// import 'package:flutter/material.dart';

// Widget listenToMany(List<Listenable> listenables, Widget Function() builder) {
//   return ListenableBuilder(
//     listenable: Listenable.merge(listenables),
//     builder: (_, _) => builder(),
//   );
// }

// Widget listenTo<T>(
//   ValueListenable<T> listenable,
//   Widget Function(T) builder,
// ) {
//   return ValueListenableBuilder<T>(
//     valueListenable: listenable,
//     builder: (_, value, _) => builder(value),
//   );
// }
