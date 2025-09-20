// import 'package:forui/forui.dart'; // Removed - using Material Design
import 'package:hospital/main.dart';
import 'package:hospital/models/patient.dart';
import 'package:hospital/repositories/generation_api.dart';

// final unsatisfiedPatients = Any(
//   generationRepository.unsatisfiedPatients.values,
// );

class UnsatisfiedPatientsBloc extends Bloc {
  late GenerationRepository generationRepository = watch();

  Iterable<Patient> get unsatisfiedPatients {
    return generationRepository.unsatisfiedPatients.values;
  }
}

class UnsatisfiedPatientsPage extends Feature<UnsatisfiedPatientsBloc> {
  @override
  Widget build(BuildContext context, controller) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unsatisfied Patients'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => navigator.back(),
          ),
        ],
      ),
      body: Column(
        children: List.generate(
          controller.unsatisfiedPatients.take(10).length,
          (i) {
            final pt = controller.unsatisfiedPatients.elementAt(i);
            return Column(
              children: [
                Text(pt.name),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(
                      // key: Key(pt.id),
                      // value: pt.satisfactionProgress,
                      ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  UnsatisfiedPatientsBloc create() => UnsatisfiedPatientsBloc();
}
