import 'package:hospital/hospital/navigator/navigator.dart';
import 'package:hospital/main.dart';

class HospitalDrawer extends UI {
  const HospitalDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: hospitalDrawerBloc.index,
      onDestinationSelected: hospitalDrawerBloc.onIndexSelected,
      children: [
        'Hospital'.text(textScaleFactor: 4).pad(),
        ...Pages.values.map(
          (page) => NavigationDrawerDestination(
            icon: Icon(page.icon),
            label: page.name.text(),
          ),
        ),
        //   ElevatedButton(
        //     onPressed: () {
        //       spark.add(ThemeMode.dark);
        //     },
        //     child: SparkBuilder(
        //       spark.stream,
        //       builder: (spark) {
        //         return spark.text();
        //       },
        //     ).pad(),
        //   ).pad(),
      ],
    );
  }
}

final spark = StreamController<ThemeMode>.broadcast()..add(ThemeMode.system);

final hospitalDrawerBlocRM = RM.inject(
  () => HospitalDrawerBloc(),
  autoDisposeWhenNotUsed: false,
);
HospitalDrawerBloc get hospitalDrawerBloc => hospitalDrawerBlocRM.state;

class HospitalDrawerBloc {
  final drawerIndexRM = RM.inject<int>(() => 0, autoDisposeWhenNotUsed: false);
  int get index => drawerIndexRM.state;
  void onIndexSelected(int value) {
    drawerIndexRM.state = value;
    navigator.toReplacement(Pages.values[value].page);
  }
}
