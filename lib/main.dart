import 'package:hospital/hospital/hospital_page.dart';
import 'package:hospital/hospital/navigator/navigator.dart';
import 'package:hospital/hospital/resources/resources.dart';
import 'package:hospital/objectbox.g.dart';
import 'main.dart';
export 'package:manager/manager.dart';

void main() async {
  final directory = await getApplicationDocumentsDirectory();
  store = await openStore(
    directory: join(directory.path, 'hospital'),
  );
  runApp(const MyApp());
  inform();
}

class MyApp extends UI {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigator.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'ER',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const HospitalPage(),
    );
  }
}
