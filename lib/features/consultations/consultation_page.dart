import 'package:hospital/main.dart';
import 'package:hospital/models/patient.dart';
import 'package:hospital/models/staff/doctor.dart';
import 'package:hospital/repositories/patients_api.dart';
import 'package:hospital/repositories/staff_api.dart';
import 'package:hospital/utils/theme.dart';

class ConsultationBloc extends Bloc {
  late final PatientsRepository patientsRepository = watch();
  late final StaffRepository staffRepository = watch();

  Iterable<Patient> get patientsNeedingConsultation =>
      patientsRepository.getByStatus(PatientStatus.admitted);

  Iterable<Doctor> get availableDoctors =>
      staffRepository.getAvailableDoctors();

  void startConsultation(Patient patient, Doctor doctor) {
    try {
      patientsRepository.startTreatment(patient);
      patientsRepository.assignDoctor(patient, doctor);
      notifyListeners('Consultation started for ${patient.name}');
    } catch (e) {
      notifyListeners('Failed to start consultation: $e');
    }
  }

  void completeConsultation(Patient patient) {
    try {
      patientsRepository.markReadyForDischarge(patient);
      notifyListeners('Consultation completed for ${patient.name}');
    } catch (e) {
      notifyListeners('Failed to complete consultation: $e');
    }
  }
}

class ConsultationPage extends Feature<ConsultationBloc> {
  @override
  ConsultationBloc create() => ConsultationBloc();

  @override
  Widget build(BuildContext context, ConsultationBloc controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultation Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(HospitalTheme.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsCard(
              'Patients Waiting',
              controller.patientsNeedingConsultation.length.toString(),
              Icons.people_outline,
              HospitalTheme.warningColor,
            ),
            const SizedBox(height: HospitalTheme.mediumSpacing),
            Text(
              'Patients Ready for Consultation',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: HospitalTheme.mediumSpacing),
            Expanded(
              child: controller.patientsNeedingConsultation.isEmpty
                  ? _buildEmptyState('No patients waiting for consultation')
                  : ListView.builder(
                      itemCount: controller.patientsNeedingConsultation.length,
                      itemBuilder: (context, index) {
                        final patient = controller.patientsNeedingConsultation
                            .elementAt(index);
                        return _buildPatientCard(patient, controller);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientCard(Patient patient, ConsultationBloc controller) {
    return Card(
      margin: const EdgeInsets.only(bottom: HospitalTheme.mediumSpacing),
      child: Padding(
        padding: const EdgeInsets.all(HospitalTheme.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 6,
                  height: 50,
                  decoration: BoxDecoration(
                    color: HospitalTheme.getUrgencyColor(patient.urgency.name),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: HospitalTheme.mediumSpacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patient.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        patient.complaints,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: HospitalTheme.smallSpacing),
                      Row(
                        children: [
                          Icon(Icons.access_time,
                              size: 16, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Text(
                            'Waiting: ${patient.waitingTime.inMinutes}m',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: HospitalTheme.mediumSpacing),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: HospitalTheme.getUrgencyColor(
                                      patient.urgency.name)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              patient.urgency.name.toUpperCase(),
                              style: TextStyle(
                                color: HospitalTheme.getUrgencyColor(
                                    patient.urgency.name),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: HospitalTheme.mediumSpacing),
            if (controller.availableDoctors.isNotEmpty) ...[
              Text(
                'Assign Doctor:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: HospitalTheme.smallSpacing),
              Wrap(
                spacing: HospitalTheme.smallSpacing,
                children: controller.availableDoctors.take(3).map((doctor) {
                  return ActionChip(
                    avatar: const CircleAvatar(
                      child: Icon(Icons.medical_services, size: 16),
                    ),
                    label: Text(doctor.name),
                    onPressed: () {
                      controller.startConsultation(patient, doctor);
                    },
                  );
                }).toList(),
              ),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(HospitalTheme.mediumSpacing),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.orange[600]),
                    const SizedBox(width: HospitalTheme.smallSpacing),
                    const Text('No doctors available'),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(HospitalTheme.cardPadding),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(HospitalTheme.cardBorderRadius),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(width: HospitalTheme.mediumSpacing),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.medical_information_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: HospitalTheme.mediumSpacing),
          Text(
            message,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
