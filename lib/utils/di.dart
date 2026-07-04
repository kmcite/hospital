import 'package:flutter/widgets.dart';

/// ===========================================================
/// Provider Core
/// ===========================================================

abstract class ProviderBase<T> {
  const ProviderBase();

  T create(Ref ref);
}

class _Provider<T> extends ProviderBase<T> {
  const _Provider(this._create);
  final T Function(Ref ref) _create;

  @override
  T create(Ref ref) => _create(ref);
}

class _AsyncProvider<T> extends ProviderBase<T> {
  const _AsyncProvider(this._create);
  final Future<T> Function(Ref ref) _create;

  @override
  T create(Ref ref) {
    throw StateError(
      'AsyncProvider<$T> has not been initialized yet.\n'
      'Ensure it is included in the ProviderScope\'s async list.',
    );
  }

  /// Evaluated exclusively during the container bootstrap phase.
  Future<T> createAsync(Ref ref) => _create(ref);
}

_Provider<T> provider<T>(T Function(Ref ref) create) => _Provider(create);
_AsyncProvider<T> asyncProvider<T>(Future<T> Function(Ref ref) create) =>
    _AsyncProvider(create);

/// ===========================================================
/// Ref Interface
/// ===========================================================

abstract class Ref {
  T call<T>(ProviderBase<T> provider);
  Future<void> get ready;
}

/// ===========================================================
/// ProviderScope
/// ===========================================================

class ProviderScope extends StatefulWidget {
  const ProviderScope({
    super.key,
    this.async = const [],
    this.child,
    this.builder,
  });

  final List<_AsyncProvider> async;
  final Widget? child;
  final WidgetBuilder? builder;

  static Ref of(BuildContext context) {
    // Ultra-fast O(1) lookup using the private InheritedWidget
    final scope = context.getInheritedWidgetOfExactType<_InheritedScope>();
    if (scope == null) {
      throw FlutterError(
        'No ProviderScope found.\nWrap your app with ProviderScope.',
      );
    }
    return scope.state;
  }

  @override
  State<ProviderScope> createState() => ProviderScopeState();
}

class ProviderScopeState extends State<ProviderScope> implements Ref {
  final _instances = <ProviderBase, Object?>{};
  final _building = <ProviderBase>{};

  @override
  late final Future<void> ready;

  @override
  void initState() {
    super.initState();
    // Preloads all declared async providers immediately at startup
    ready = () async {
      await Future.wait(widget.async.map((provider) => _preload(provider)));
    }();
  }

  @override
  T call<T>(ProviderBase<T> provider) => _read(provider);

  T _read<T>(ProviderBase<T> provider) {
    final existing = _instances[provider];
    if (existing != null) return existing as T;

    if (!_building.add(provider)) {
      throw StateError('Circular dependency detected for $provider');
    }

    try {
      final value = provider.create(this);
      _instances[provider] = value;
      return value;
    } finally {
      _building.remove(provider);
    }
  }

  Future<T> _preload<T>(_AsyncProvider<T> provider) async {
    final existing = _instances[provider];
    if (existing != null) return existing as T;

    if (!_building.add(provider)) {
      throw StateError(
        'Circular dependency detected during async preload for $provider',
      );
    }

    try {
      final value = await provider.createAsync(this);
      _instances[provider] = value;
      return value;
    } finally {
      _building.remove(provider);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(
      state: this,
      child: Builder(
        builder: (context) {
          return widget.child ??
              widget.builder?.call(context) ??
              SizedBox.shrink();
        },
      ),
    );
  }
}

/// ===========================================================
/// Private O(1) Efficiency Performance Link
/// ===========================================================

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    required this.state,
    required super.child,
  });

  final ProviderScopeState state;

  // DI graph structures are static; we don't want to trigger reactive UI rebuilds here
  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}

/// ===========================================================
/// BuildContext Extensions
/// ===========================================================

extension ProviderContext on BuildContext {
  Ref get ref => ProviderScope.of(this);
  T get<T>(ProviderBase<T> provider) => ref(provider);
}
