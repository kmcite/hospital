import 'package:hospital/hospital/navigator/drawer.dart';
import 'package:hospital/main.dart';

class AppScaffold extends UI {
  const AppScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
  });

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HospitalDrawer(),
      appBar: appBar ?? AppBar(),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
