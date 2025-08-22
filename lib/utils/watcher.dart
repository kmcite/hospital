import 'package:hospital/main.dart';

class GUI extends UI {
  const GUI(
    this.builder, {
    this.didMount,
    this.didUnmount,
    super.key,
    super.debugLabel,
    super.dependencies,
  });
  final Widget Function() builder;
  @override
  Widget build(BuildContext context) => builder();
  final void Function()? didMount;
  final void Function()? didUnmount;
  @override
  void initState() {
    super.initState();
    didMount?.call();
  }

  @override
  void dispose() {
    didUnmount?.call();
    super.dispose();
  }
}

abstract class UI<T extends Widget> extends StatefulWidget {
  const UI({
    super.key,
    this.debugLabel,
    this.dependencies = const [],
  });

  T build(BuildContext context);
  final String? debugLabel;
  final List<ReadonlySignal<dynamic>> dependencies;

  @override
  State<UI<T>> createState() => _UI<T>();

  void initState() {}

  void dispose() {}
}

class _UI<T extends Widget> extends State<UI<T>> with SignalsMixin {
  late final result = createComputed(() {
    return widget.build(context);
  }, debugLabel: widget.debugLabel);
  bool _init = true;

  @override
  void initState() {
    super.initState();
    for (final dep in widget.dependencies) {
      bindSignal(dep);
    }
    widget.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    final target = SignalsObserver.instance;
    if (target is DevToolsSignalsObserver) {
      target.reassemble();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      result.recompute();
      if (mounted) setState(() {});
      result.value;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      _init = false;
      return;
    }
    result.recompute();
  }

  @override
  void didUpdateWidget(covariant UI<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dependencies != widget.dependencies) {
      for (final dep in oldWidget.dependencies) {
        final index = widget.dependencies.indexOf(dep);
        if (index == -1) unbindSignal(dep);
      }
      for (final dependency in widget.dependencies) {
        bindSignal(dependency);
      }
    } else if (oldWidget.build != widget.build) {
      result.recompute();
    }
  }

  @override
  Widget build(BuildContext context) {
    return result.value;
  }

  @override
  void dispose() {
    widget.dispose();
    super.dispose();
  }
}
