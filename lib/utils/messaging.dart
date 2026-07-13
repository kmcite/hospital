import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

typedef MessageHandler<M> = void Function(M message);

final Map<Type, List<Function>> _messaging = {};

VoidCallback listen<M>(MessageHandler<M> handler) {
  final handlers = _messaging.putIfAbsent(M, () => <Function>[]);

  void wrapper(dynamic message) => handler(message as M);

  handlers.add(wrapper);

  debugPrint('[$M] [Subscribed]');

  var disposed = false;

  return () {
    if (disposed) return;
    disposed = true;

    final handlers = _messaging[M];
    if (handlers == null) return;

    handlers.remove(wrapper);

    if (handlers.isEmpty) {
      _messaging.remove(M);
    }
    debugPrint('[$M] [Disposed]');
  };
}

void send<M>(M message) {
  final handlers = _messaging[M];
  if (handlers == null) return;

  // Fast path.
  for (var i = 0; i < handlers.length; i++) {
    (handlers[i] as void Function(dynamic))(message);
  }

  debugPrint('[$M] [Sent]');
}
