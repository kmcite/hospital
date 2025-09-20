import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:navigation_builder/navigation_builder.dart';

bool logging = true;
final navigator = NavigationBuilder.navigate;

/// ----------------------
/// Bloc - listens to Repositories & notifies UI
/// ----------------------

abstract class Bloc with ChangeNotifier {
  final _watched = <Repository>{};

  T watch<T extends Repository>() {
    final instance = repositories[T];
    if (instance == null) throw Exception('$T not found');
    if (!_watched.contains(instance)) {
      _watched.add(instance);
      instance.addListener(notifyListeners);
      if (logging) log('[$runtimeType] <--> $T');
    }
    return instance as T;
  }

  void initState() {
    if (logging) log('[$runtimeType] @initState');
  }

  @override
  @mustCallSuper
  void dispose() {
    for (var repo in _watched) {
      repo.removeListener(notifyListeners);
    }
    _watched.clear();
    if (logging) log('[$runtimeType] @dispose');
    super.dispose();
  }

  @override
  void notifyListeners([String message = '']) {
    super.notifyListeners();
    if (logging) {
      final suffix = message.isNotEmpty ? ' → $message' : '';
      log('[$runtimeType] notifyListeners$suffix');
    }
  }
}

/// ----------------------
/// Repository - holds state & notifies dependents
/// ----------------------
abstract class Repository extends ChangeNotifier {
  @override
  void notifyListeners([String message = '']) {
    super.notifyListeners();
    if (logging) {
      final suffix = message.isNotEmpty ? ' → $message' : '';
      log('[$runtimeType] notifyListeners$suffix');
    }
  }

  @mustCallSuper
  void dispose() {
    repositories.removeWhere((_, val) => val == this);
    super.dispose();
  }
}

/// ----------------------
/// Registry - dependency tracking
/// ----------------------
final repositories = <Type, Repository>{};
final services = <Type, dynamic>{};

/// use to register or find services
T find<T>([T? instance]) {
  if (instance != null) {
    services[T] = instance;
    return instance;
  } else {
    final found = services[T];
    if (found == null) throw Exception('$T not found');
    return found as T;
  }
}

/// used to register repositories
void put<T extends Repository>(T instance) {
  repositories[T] = instance;
  if (logging) log('[Registry] Registered <$T>');
}

/// ----------------------
/// Feature - StatefulWidget bound to a Bloc
/// ----------------------
abstract class Feature<T extends Bloc> extends StatefulWidget {
  const Feature({super.key});
  T create();
  Widget build(BuildContext context, T controller);

  @override
  State<Feature<T>> createState() => _FeatureState<T>();
}

class _FeatureState<T extends Bloc> extends State<Feature<T>> {
  late final T controller;

  @override
  void initState() {
    super.initState();
    controller = widget.create();
    controller.initState();
    controller.addListener(_listener);
  }

  void _listener() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_listener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, controller);
}

/// ----------------------
/// AppRunner - dependency bootstrapper
void AppRunner({
  required Future<void> Function() initialize,
  required Widget app,
}) async {
  await initialize();
  runApp(app);
}

void disposeAll() {
  for (final instance in repositories.values) {
    instance.dispose();
  }
  repositories.clear();
  services.clear();
  if (logging) log('Registry disposed');
}
