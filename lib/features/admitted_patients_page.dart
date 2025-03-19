import 'package:forui/forui.dart';
import 'package:hospital/domain/models/patient.dart';
import 'package:hospital/domain/api/patients_repository.dart';
import 'package:hospital/features/admitted_patient_page.dart';
import 'package:hospital/main.dart';
import 'package:hospital/navigator.dart';

mixin class AdmittedPatientsBloc {
  Iterable<Patient> get admittedPatients {
    return patientsRepository.getPatientsByStatus(Status.admitted);
  }

  void remove(Patient patient) {
    patientsRepository.remove(patient.id);
  }
}

class AdmittedPatientsPage extends UI with AdmittedPatientsBloc {
  const AdmittedPatientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        prefixActions: [
          FHeaderAction.back(onPress: navigator.back),
        ],
        title: 'Admitted Patients'.text(),
      ),
      content: FTileGroup(
        divider: FTileDivider.full,
        children: admittedPatients.map(
          (patient) {
            return FTile(
              title: patient.name.text(),
              subtitle: Column(
                children: [
                  patient.symptom.text(),
                ],
              ),
              onPress: () {
                admittedPatientBloc.set(patient);
                navigator.to(AdmittedPatientPage());
              },
              suffixIcon: FButton.icon(
                style: FButtonStyle.destructive,
                onPress: () => remove(patient),
                child: FIcon(FAssets.icons.delete),
              ),
            );
          },
        ).toList(),
      ),
    );

    // return FScaffold(
    //   content: admittedPatientsBloc.admittedPatients.isEmpty
    //       ? Center(child: Text('No patients admitted.'))
    //       : FTileGroup.builder(
    //           divider: FTileDivider.full,
    //           count: admittedPatientsBloc.admittedPatients.length,
    //           tileBuilder: (context, index) {
    //             final patient =
    //                 admittedPatientsBloc.admittedPatients.elementAt(index);
    //             final progress =
    //                 1 - (patient.remainingTime / patient.admissionTime);
    //             return admittedPatientsBloc.timerRM.onAll(
    //               onError: (error, refreshError) => FButton.icon(
    //                 onPress: () {},
    //                 child: FButtonSpinner(),
    //               ),
    //               onWaiting: () => FButton.icon(
    //                 onPress: () {},
    //                 child: FButtonSpinner(),
    //               ),
    //               onData: (ticks) {
    //                 return FTile(
    //                   prefixIcon: FIcon(FAssets.icons.bed),
    //                   title: patient.name.text(),
    //                   subtitle: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text('Remaining Time: ${patient.remainingTime}s'),
    //                       Text(
    //                         'Satisfaction: ${patient.satisfaction.toStringAsFixed(1)}%',
    //                       ),
    //                       FProgress(value: progress),
    //                       SizedBox(
    //                         height: 0,
    //                         child: ticks.text(),
    //                       )
    //                     ],
    //                   ),
    //                   onPress: () {
    //                     admittedPatientBloc.set(patient);
    //                     navigator.to(AdmittedPatientPage());
    //                   },

    //                 );
    //               },
    //             );
    //           },
    //         ),
    // );
  }
}
