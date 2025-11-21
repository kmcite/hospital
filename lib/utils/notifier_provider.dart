import 'package:hospital/main.dart';
import 'package:provider/provider.dart' show Consumer;

/// just scoping to one widget only
class NotifierProvider<T extends Listenable> extends StatelessWidget {
  final T Function(BuildContext context) create;
  final Widget Function(BuildContext context, T listenable) builder;

  const NotifierProvider({
    super.key,
    required this.create,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableProvider<T>(
      create: create,
      child: Consumer<T>(
        builder: (context, listenable, child) => builder(context, listenable),
      ),
    );
  }
}
