import 'package:hospital/main.dart';
import 'package:hospital/models/patient.dart';
import 'package:hospital/utils/list_view.dart';
import 'package:hospital/utils/theme.dart';

import '../../repositories/patients_api.dart';

class ManagedPatientsBloc extends Bloc {
  late final patientsRepository = watch<PatientsRepository>();

  Iterable<Patient> get managedPatients {
    return patientsRepository.managed;
  }

  int get amountOfManagedPatients => managedPatients.length;
}

class ManagedPatients extends Feature<ManagedPatientsBloc> {
  @override
  ManagedPatientsBloc create() => ManagedPatientsBloc();

  @override
  Widget build(context, controller) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Managed Patients'),
      ),
      body: Padding(
        padding: EdgeInsets.all(HospitalTheme.defaultPadding),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(HospitalTheme.cardPadding),
              decoration: BoxDecoration(
                color: HospitalTheme.primaryColor.withOpacity(0.1),
                borderRadius:
                    BorderRadius.circular(HospitalTheme.cardBorderRadius),
                border: Border.all(
                    color: HospitalTheme.primaryColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.people,
                    color: HospitalTheme.primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: HospitalTheme.mediumSpacing),
                  Text(
                    'Total Managed Patients: ${controller.amountOfManagedPatients}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: HospitalTheme.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: HospitalTheme.mediumSpacing),
            Expanded(
              child: controller.managedPatients.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people_outline,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: HospitalTheme.mediumSpacing),
                          Text(
                            'No managed patients',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: HospitalTheme.smallSpacing),
                          Text(
                            'Patients will appear here when they are being managed',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : listView(
                      controller.managedPatients,
                      (patient) {
                        return Container(
                          margin: EdgeInsets.only(
                              bottom: HospitalTheme.smallSpacing),
                          child: Card(
                            child: ListTile(
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: HospitalTheme.getUrgencyColor(
                                          patient.urgency.name)
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: HospitalTheme.getUrgencyColor(
                                            patient.urgency.name)
                                        .withOpacity(0.3),
                                  ),
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: HospitalTheme.getUrgencyColor(
                                      patient.urgency.name),
                                ),
                              ),
                              title: Text(
                                patient.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: HospitalTheme.smallSpacing),
                                  Text(
                                    patient.complaints,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: HospitalTheme.smallSpacing),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: HospitalTheme.getStatusColor(
                                                  patient.status.name)
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: HospitalTheme.getStatusColor(
                                                    patient.status.name)
                                                .withOpacity(0.3),
                                          ),
                                        ),
                                        child: Text(
                                          patient.status.name.toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: HospitalTheme.getStatusColor(
                                                patient.status.name),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width: HospitalTheme.smallSpacing),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: HospitalTheme.getUrgencyColor(
                                                  patient.urgency.name)
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color:
                                                HospitalTheme.getUrgencyColor(
                                                        patient.urgency.name)
                                                    .withOpacity(0.3),
                                          ),
                                        ),
                                        child: Text(
                                          patient.urgency.name.toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                HospitalTheme.getUrgencyColor(
                                                    patient.urgency.name),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'ID',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  Text(
                                    patient.id.toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
