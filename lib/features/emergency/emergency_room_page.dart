import 'package:hospital/main.dart';
import 'package:hospital/models/patient.dart';
import 'package:hospital/models/staff/doctor.dart';
import 'package:hospital/models/staff/nurse.dart';
import 'package:hospital/repositories/patients_api.dart';
import 'package:hospital/repositories/staff_api.dart';
import 'package:hospital/utils/theme.dart';

class EmergencyRoomBloc extends Bloc {
  late final PatientsRepository patientsRepository = watch();
  late final StaffRepository staffRepository = watch();

  Iterable<Patient> get emergencyPatients => patientsRepository
      .getByUrgency(UrgencyLevel.critical)
      .followedBy(patientsRepository.getByUrgency(UrgencyLevel.high));

  Iterable<Patient> get criticalPatients =>
      patientsRepository.getByUrgency(UrgencyLevel.critical);

  Iterable<Patient> get highPriorityPatients =>
      patientsRepository.getByUrgency(UrgencyLevel.high);

  Iterable<Doctor> get emergencyDoctors => staffRepository.doctors.where(
      (doctor) =>
          doctor.specialization?.toLowerCase().contains('emergency') == true ||
          doctor.specialization?.toLowerCase().contains('trauma') == true);

  Iterable<Nurse> get availableNurses => staffRepository.getAvailableNurses();

  void prioritizePatient(Patient patient) {
    if (patient.urgency != UrgencyLevel.critical) {
      // Upgrade urgency to critical
      final updatedPatient = Patient.create(
        name: patient.name,
        complaints: patient.complaints,
        urgency: UrgencyLevel.critical,
        isInsured: patient.isInsured,
      );
      updatedPatient.id = patient.id;
      patientsRepository.updatePatient(updatedPatient);
      notifyListeners('Patient ${patient.name} marked as critical');
    }
  }

  void assignEmergencyTeam(Patient patient, Doctor doctor, Nurse nurse) {
    try {
      patientsRepository.assignDoctor(patient, doctor);
      patientsRepository.assignNurse(patient, nurse);
      patientsRepository.startTreatment(patient);
      notifyListeners('Emergency team assigned to ${patient.name}');
    } catch (e) {
      notifyListeners('Failed to assign emergency team: $e');
    }
  }

  void transferToICU(Patient patient) {
    try {
      // Mark as under treatment in ICU
      patientsRepository.startTreatment(patient);
      notifyListeners('${patient.name} transferred to ICU');
    } catch (e) {
      notifyListeners('Failed to transfer to ICU: $e');
    }
  }
}

class EmergencyRoomPage extends Feature<EmergencyRoomBloc> {
  @override
  EmergencyRoomBloc create() => EmergencyRoomBloc();

  @override
  Widget build(BuildContext context, EmergencyRoomBloc controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Room'),
        backgroundColor: Colors.red[600],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.local_hospital),
            onPressed: () {
              // Navigate to ICU management
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.notifyListeners();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(HospitalTheme.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Emergency Stats
              _buildEmergencyStats(controller),
              const SizedBox(height: HospitalTheme.largeSpacing),

              // Critical Patients Section
              _buildCriticalSection(controller),
              const SizedBox(height: HospitalTheme.largeSpacing),

              // High Priority Patients Section
              _buildHighPrioritySection(controller),
              const SizedBox(height: HospitalTheme.largeSpacing),

              // Emergency Staff Section
              _buildEmergencyStaffSection(controller, context),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Quick admit emergency patient
          _showQuickAdmitDialog(context, controller);
        },
        icon: const Icon(Icons.emergency),
        label: const Text('Quick Admit'),
        backgroundColor: Colors.red[600],
      ),
    );
  }

  Widget _buildEmergencyStats(EmergencyRoomBloc controller) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Critical',
            controller.criticalPatients.length.toString(),
            Icons.emergency,
            Colors.red,
          ),
        ),
        const SizedBox(width: HospitalTheme.mediumSpacing),
        Expanded(
          child: _buildStatCard(
            'High Priority',
            controller.highPriorityPatients.length.toString(),
            Icons.priority_high,
            Colors.orange,
          ),
        ),
        const SizedBox(width: HospitalTheme.mediumSpacing),
        Expanded(
          child: _buildStatCard(
            'Available Staff',
            '${controller.emergencyDoctors.length + controller.availableNurses.length}',
            Icons.medical_services,
            Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildCriticalSection(EmergencyRoomBloc controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.emergency, color: Colors.red[600], size: 24),
            const SizedBox(width: HospitalTheme.smallSpacing),
            Text(
              'Critical Patients',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red[600],
              ),
            ),
            const Spacer(),
            if (controller.criticalPatients.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'URGENT',
                  style: TextStyle(
                    color: Colors.red[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: HospitalTheme.mediumSpacing),
        if (controller.criticalPatients.isEmpty)
          _buildEmptyEmergencyState('No critical patients')
        else
          ...controller.criticalPatients.map((patient) =>
              _buildEmergencyPatientCard(patient, controller, true)),
      ],
    );
  }

  Widget _buildHighPrioritySection(EmergencyRoomBloc controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.priority_high, color: Colors.orange[600], size: 24),
            const SizedBox(width: HospitalTheme.smallSpacing),
            Text(
              'High Priority Patients',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: HospitalTheme.mediumSpacing),
        if (controller.highPriorityPatients.isEmpty)
          _buildEmptyEmergencyState('No high priority patients')
        else
          ...controller.highPriorityPatients.map((patient) =>
              _buildEmergencyPatientCard(patient, controller, false)),
      ],
    );
  }

  Widget _buildEmergencyPatientCard(
      Patient patient, EmergencyRoomBloc controller, bool isCritical) {
    return Card(
      margin: const EdgeInsets.only(bottom: HospitalTheme.mediumSpacing),
      elevation: isCritical ? 8 : 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(HospitalTheme.cardBorderRadius),
          border: Border.all(
            color: isCritical ? Colors.red : Colors.orange,
            width: isCritical ? 2 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(HospitalTheme.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (isCritical)
                    Icon(Icons.emergency, color: Colors.red[600], size: 20)
                  else
                    Icon(Icons.priority_high,
                        color: Colors.orange[600], size: 20),
                  const SizedBox(width: HospitalTheme.smallSpacing),
                  Expanded(
                    child: Text(
                      patient.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color:
                            isCritical ? Colors.red[600] : Colors.orange[600],
                      ),
                    ),
                  ),
                  if (isCritical)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'CRITICAL',
                        style: TextStyle(
                          color: Colors.red[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: HospitalTheme.smallSpacing),

              Text(
                patient.complaints,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: HospitalTheme.smallSpacing),

              Row(
                children: [
                  Icon(Icons.access_time, size: 14, color: Colors.grey[500]),
                  const SizedBox(width: 4),
                  Text(
                    'Waiting: ${patient.waitingTime.inMinutes}m',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                  if (patient.isInsured) ...[
                    const SizedBox(width: HospitalTheme.mediumSpacing),
                    Icon(Icons.health_and_safety,
                        size: 14, color: Colors.green[600]),
                    const SizedBox(width: 4),
                    Text(
                      'Insured',
                      style: TextStyle(
                        color: Colors.green[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: HospitalTheme.mediumSpacing),

              // Emergency Actions
              Wrap(
                spacing: HospitalTheme.smallSpacing,
                children: [
                  if (!isCritical)
                    ActionChip(
                      avatar: Icon(Icons.emergency,
                          size: 16, color: Colors.red[600]),
                      label: const Text('Mark Critical'),
                      onPressed: () => controller.prioritizePatient(patient),
                      backgroundColor: Colors.red[50],
                    ),
                  ActionChip(
                    avatar: const Icon(Icons.local_hospital, size: 16),
                    label: const Text('ICU Transfer'),
                    onPressed: () => controller.transferToICU(patient),
                    backgroundColor: Colors.blue[50],
                  ),
                  if (controller.emergencyDoctors.isNotEmpty &&
                      controller.availableNurses.isNotEmpty)
                    ActionChip(
                      avatar: const Icon(Icons.medical_services, size: 16),
                      label: const Text('Assign Team'),
                      onPressed: () => controller.assignEmergencyTeam(
                        patient,
                        controller.emergencyDoctors.first,
                        controller.availableNurses.first,
                      ),
                      backgroundColor: Colors.green[50],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmergencyStaffSection(
      EmergencyRoomBloc controller, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Emergency Staff Status',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: HospitalTheme.mediumSpacing),
        Row(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(HospitalTheme.cardPadding),
                  child: Column(
                    children: [
                      Icon(Icons.medical_services,
                          color: Colors.blue[600], size: 32),
                      const SizedBox(height: HospitalTheme.smallSpacing),
                      Text(
                        '${controller.emergencyDoctors.length}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[600],
                        ),
                      ),
                      const Text('Emergency Doctors'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: HospitalTheme.mediumSpacing),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(HospitalTheme.cardPadding),
                  child: Column(
                    children: [
                      Icon(Icons.local_hospital,
                          color: Colors.green[600], size: 32),
                      const SizedBox(height: HospitalTheme.smallSpacing),
                      Text(
                        '${controller.availableNurses.length}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[600],
                        ),
                      ),
                      const Text('Available Nurses'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(HospitalTheme.cardPadding),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: HospitalTheme.smallSpacing),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyEmergencyState(String message) {
    return Container(
      padding: const EdgeInsets.all(HospitalTheme.extraLargeSpacing),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.healing,
              size: 48,
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
      ),
    );
  }

  void _showQuickAdmitDialog(
      BuildContext context, EmergencyRoomBloc controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quick Emergency Admit'),
        content: const Text('This will create a critical patient admission.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Quick admit with default emergency data
              controller.patientsRepository.createPatient(
                name: 'Emergency Patient ${DateTime.now().millisecond}',
                complaints:
                    'Emergency admission - requires immediate attention',
                urgency: UrgencyLevel.critical,
                isInsured: false,
              );
              Navigator.pop(context);
              controller.notifyListeners('Emergency patient admitted');
            },
            child: const Text('Admit'),
          ),
        ],
      ),
    );
  }
}
