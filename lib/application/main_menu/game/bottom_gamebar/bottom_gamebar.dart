import 'package:hospital/main.dart';

class BottomGamebar extends StatelessWidget {
  const BottomGamebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Placeholder(
        child: FHeader(
          title: Text("Bottom Gamebar"),
        ),
      ),
    );
  }
}
