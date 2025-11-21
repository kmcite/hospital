import 'dart:developer' show log;

/// CONCEPT

final _listeners = <Type, List<Function>>{};

void on<E>(void Function(E event) listener) {
  (_listeners[E] ??= []).add(listener);
  log('registered', name: E.toString());
}

void publish<E>(E event) {
  final listeners = _listeners[E];
  if (listeners == null) return;
  for (final fn in List<Function>.from(listeners)) {
    (fn as void Function(E))(event);
  }
  log(
    'published',
    name: E.toString(),
  );
}

void off<E>(void Function(E event) listener) {
  final listeners = _listeners[E];
  if (listeners == null) return;
  listeners.remove(listener);
  if (listeners.isEmpty) _listeners.remove(E);
}
