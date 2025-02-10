import 'package:hospital/hospital/hospital_bloc.dart';
import 'package:hospital/main.dart';

class WaitingButton extends UI {
  const WaitingButton({super.key});

  @override
  Widget build(BuildContext context) {
    // final totalTime = hospitalBloc.nextPatientInterval.toDouble();
    // final remainingTime = hospitalBloc.nextPatientIn.toDouble();
    final progress = (/*totalTime*/ 0 - 0 /*remainingtime*/) / 1 /*totalTime*/;

    return AnimatedBuilder(
      animation: hospitalBloc,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade300,
                color: Colors.blue,
                strokeWidth: 6,
              ),
            ),
            // Text(
            //   '${hospitalBloc.nextPatientIn}s',
            //   style: const TextStyle(fontSize: 16),
            // ),
          ],
        );
      },
    );
  }
}
