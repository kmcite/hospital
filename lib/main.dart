import 'package:forui/forui.dart';
import 'package:hospital/domain/api/dark.dart';
import 'package:hospital/features/hospital_page.dart';
import 'package:hospital/navigator.dart';
import 'package:hospital/objectbox.g.dart';
import 'main.dart';
export 'package:manager/manager.dart';

void main() => manager(HospitalApp(), openStore: openStore);

mixin HospitalBloc {
  GlobalKey<NavigatorState> get navigatorKey => navigator.navigatorKey;
  bool get dark => darkRM.state;
}

class HospitalApp extends UI with HospitalBloc {
  const HospitalApp({super.key});

  @override
  Widget build(_) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return FTheme(
          data: dark ? FThemes.yellow.dark : FThemes.blue.light,
          child: child!,
        );
      },
      home: const HospitalPage(),
    );
  }
}

typedef UI = ReactiveStatelessWidget;
