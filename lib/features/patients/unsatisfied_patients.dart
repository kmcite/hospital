import 'package:forui/forui.dart';
import 'package:hospital/main.dart';
import 'package:hospital/repositories/generation_api.dart';

final unsatisfiedPatients = computed(
  () => generationRepository.unsatisfiedPatients.values,
);

class UnsatisfiedPatientsPage extends UI {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text('Unsatisfied Patients'),
        suffixes: [
          FHeaderAction(
            icon: Icon(Icons.clean_hands),
            onPress: () {},
          ),
        ],
      ),
      child: Column(
        children: List.generate(
          unsatisfiedPatients().take(10).length,
          (i) {
            final pt = unsatisfiedPatients().elementAt(i);
            return Column(
              children: [
                pt.name.text(),
                FProgress(
                  key: Key(pt.id),
                  value: pt.satisfactionProgress(),
                ).pad()
              ],
            );
          },
        ),
      ),
    );
  }
}
