import 'dart:async' show StreamSubscription, scheduleMicrotask;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Unified evaluation context tracker (handles both UI nodes and Computed signals).
_ObserverContext? _currentContext;

abstract class _ObserverContext {
  void link(Signal<dynamic> signal);
}

// ---------------------------------------------------------------------------
// Base Signal Engine (Maximizes Ergonomics & Eliminates Type Casting)
// ---------------------------------------------------------------------------

abstract class Signal<S> {
  S get state;

  /// Consolidated internal reactive observer channels
  final Set<VoidCallback> _observers = {};

  /// Tracking variable to eliminate O(N) Set copying during dependency evaluation passes
  int _lastSeenGeneration = 0;

  void _unsubscribe(VoidCallback observer) {
    _observers.remove(observer);
  }
}

// ---------------------------------------------------------------------------
// Spark (Formerly WritableSignal - Scalable Logic Base Class)
// ---------------------------------------------------------------------------

abstract class Spark<S> extends Signal<S> {
  /// Abstract getter to define the default value in extending logic classes.
  S get initialState;

  late S _state = initialState;

  @override
  S get state {
    _currentContext?.link(this);
    return _state;
  }

  set state(S value) {
    if (identical(_state, value)) return;
    _state = value;

    // Snapshot protection avoiding concurrent modification during executions
    final observersSnapshot = _observers.toList(growable: false);
    for (final observer in observersSnapshot) {
      observer();
    }
  }

  /// Read or update the value.
  S call([S Function(S current)? updater]) {
    if (updater != null) {
      state = updater(_state);
    }
    return state;
  }

  late var update = call;

  /// Listens directly to a stream and updates the signal's state.
  StreamSubscription<S> bind(Stream<S> stream) {
    return stream.listen((value) {
      state = value;
    });
  }
}

/// Standalone concrete implementation of Spark for simple inline instances.
class _InlineSpark<S> extends Spark<S> {
  @override
  final S initialState;

  _InlineSpark(this.initialState);
}

/// Creates a standard inline spark instance.
Spark<S> signal<S>(S initialState) => _InlineSpark<S>(initialState);

// ---------------------------------------------------------------------------
// Computed Signal (Zero-Allocation Dependency Evaluation Pass)
// ---------------------------------------------------------------------------

class Computed<S> extends Signal<S> implements _ObserverContext {
  final S Function() _selector;
  final Set<Signal<dynamic>> _dependencies = {};

  late S _value;
  bool _isDirty = true;
  int _evaluationGeneration = 0;

  Computed(this._selector);

  @override
  S get state {
    _currentContext?.link(this);
    if (_isDirty) {
      _evaluate();
    }
    return _value;
  }

  void _evaluate() {
    _evaluationGeneration++;

    final previousContext = _currentContext;
    _currentContext = this;

    try {
      _value = _selector();
      _isDirty = false;
    } finally {
      _currentContext = previousContext;

      // Prune stale dependencies without cloning sets.
      _dependencies.removeWhere((dep) {
        if (dep._lastSeenGeneration != _evaluationGeneration) {
          dep._unsubscribe(_notify);
          return true;
        }
        return false;
      });

      if (_observers.isEmpty) {
        _teardown();
      }
    }
  }

  @override
  void link(Signal<dynamic> signal) {
    signal._lastSeenGeneration = _evaluationGeneration;
    if (_dependencies.add(signal)) {
      signal._observers.add(_notify);
    }
  }

  void _notify() {
    if (_isDirty) return;
    _isDirty = true;

    final observersSnapshot = _observers.toList(growable: false);
    for (final observer in observersSnapshot) {
      observer();
    }
  }

  @override
  void _unsubscribe(VoidCallback observer) {
    super._unsubscribe(observer);
    if (_observers.isEmpty) {
      _teardown();
    }
  }

  void _teardown() {
    for (final dep in _dependencies) {
      dep._unsubscribe(_notify);
    }
    _dependencies.clear();
    _isDirty = true;
  }

  /// Read the current computed value.
  S call() => state;
}

/// Creates a derived/computed signal dependent on other signals.
Computed<S> computed<S>(S Function() selector) => Computed<S>(selector);

// ---------------------------------------------------------------------------
// UI Reactivity Framework (Optimized Lifecycle Tracking)
// ---------------------------------------------------------------------------

abstract class UI extends StatefulWidget {
  const UI({super.key});

  @override
  State<UI> createState() => _UIState();

  Widget build(BuildContext context);
}

class _UIState extends State<UI> implements _ObserverContext {
  final _dependencies = <Signal<dynamic>>{};
  bool _microtaskScheduled = false;
  int _buildGeneration = 0;

  @override
  void link(Signal<dynamic> signal) {
    signal._lastSeenGeneration = _buildGeneration;
    if (_dependencies.add(signal)) {
      signal._observers.add(_observer);
    }
  }

  void _observer() {
    if (!mounted) return;

    final phase = SchedulerBinding.instance.schedulerPhase;
    if (phase == SchedulerPhase.persistentCallbacks ||
        phase == SchedulerPhase.midFrameMicrotasks) {
      if (_microtaskScheduled) return;
      _microtaskScheduled = true;

      scheduleMicrotask(() {
        _microtaskScheduled = false;
        if (mounted) setState(() {});
      });
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    _buildGeneration++;

    final previous = _currentContext;
    _currentContext = this;

    try {
      return widget.build(context);
    } finally {
      _currentContext = previous;

      // Sweeps away dependencies that weren't touched during the current layout pass.
      _dependencies.removeWhere((signal) {
        if (signal._lastSeenGeneration != _buildGeneration) {
          signal._unsubscribe(_observer);
          return true;
        }
        return false;
      });
    }
  }

  @override
  void dispose() {
    for (final signal in _dependencies) {
      signal._unsubscribe(_observer);
    }
    super.dispose();
  }
}
