// ignore_for_file: avoid_unnecessary_containers

import 'package:hospital/application/departments/reception/patient_details.dart';
import 'package:hospital/main.dart';

class FloatingOverlaysNotifier extends ChangeNotifier {
  var listOfVisibleOverlays = <Widget>[
    PatientDetailsOverlay(),
  ];

  void addOverlay(Widget overlay) {
    listOfVisibleOverlays.add(overlay);
    notifyListeners();
  }
}

class FloatingOverlays extends StatelessWidget {
  const FloatingOverlays({super.key});

  @override
  Widget build(BuildContext context) {
    return NotifierProvider(
      create: (context) => FloatingOverlaysNotifier(),
      builder: (context, flOvaerlays) => CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                for (var overlay in flOvaerlays.listOfVisibleOverlays) overlay,
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Text('FloatingOverlays', style: TextStyle(fontSize: 24)),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Text('Statistics', style: TextStyle(fontSize: 24)),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Text('Notifications'),
            ),
          ),
        ],
      ),
    );
  }
}
