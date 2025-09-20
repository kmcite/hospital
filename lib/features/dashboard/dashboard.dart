import 'package:hospital/features/balance/receipts.dart';
import 'package:hospital/features/patients/managed_patients.dart';
import 'package:hospital/features/patients/referred_patients.dart';
import 'package:hospital/features/patients/unsatisfied_patients.dart';
import 'package:hospital/features/patients/patient_registration_page.dart';
import 'package:hospital/features/consultations/consultation_page.dart';
import 'package:hospital/features/emergency/emergency_room_page.dart';
import 'package:hospital/features/staff/all_staff.dart';
import 'package:hospital/main.dart';
import 'package:hospital/models/patient.dart';
import 'package:hospital/features/settings/settings.dart';
import 'package:hospital/repositories/settings_api.dart';

import '../../repositories/balance_api.dart';
import '../../repositories/generation_api.dart';
import '../../repositories/patients_api.dart';
import '../../repositories/staff_api.dart';

class DashboardBloc extends Bloc {
  /// SOURCES
  late final balanceRepository = watch<BalanceRepository>();
  late final generationRepository = watch<GenerationRepository>();
  late final settingsRepository = watch<SettingsRepository>();
  late final patientsRepository = watch<PatientsRepository>();
  late final staffRepository = watch<StaffRepository>();

  /// GLOBAL STATE
  double get remainingTimeForNextPatient {
    final current = generationRepository.currentRemainingTimeForNext;
    final total = generationRepository.totalRemainingTimeForNext;
    if (current == 0) return 0;
    return current / total;
  }

  String get balance => balanceRepository.balance.toStringAsFixed(0);
  String get hospitalName => settingsRepository.hospitalName;

  // Enhanced dashboard data
  Iterable<Patient> get waitingPatients =>
      patientsRepository.getWaitingPatients();
  Iterable<Patient> get admittedPatients =>
      patientsRepository.getAdmittedPatients();
  Iterable<Patient> get underTreatment =>
      patientsRepository.getPatientsUnderTreatment();
  Iterable<Patient> get readyForDischarge =>
      patientsRepository.getReadyForDischarge();

  Map<PatientStatus, int> get patientStats =>
      patientsRepository.getStatusStatistics();
  Map<UrgencyLevel, int> get urgencyStats =>
      patientsRepository.getUrgencyStatistics();

  int get totalDoctors => staffRepository.getDoctorsCount();
  int get totalNurses => staffRepository.getNursesCount();
  int get totalReceptionists => staffRepository.getReceptionistsCount();

  int get availableDoctors => staffRepository.getAvailableDoctors().length;
  int get availableNurses => staffRepository.getAvailableNurses().length;
  int get availableReceptionists =>
      staffRepository.getAvailableReceptionists().length;

  double get averageSatisfaction =>
      patientsRepository.getAverageSatisfactionScore();
  Duration get averageWaitTime => patientsRepository.getAverageWaitingTime();

  // Quick actions
  void admitNextPatient() {
    final nextPatient = waitingPatients.firstOrNull;
    if (nextPatient != null) {
      patientsRepository.admitPatient(nextPatient);
    }
  }

  void dischargeReadyPatients() {
    for (final patient in readyForDischarge) {
      patientsRepository.dischargePatient(patient);
    }
  }

  void generateNewStaff() {
    staffRepository.generateStaff();
  }
}

class Dashboard extends Feature<DashboardBloc> {
  @override
  DashboardBloc create() => DashboardBloc();

  @override
  Widget build(BuildContext context, controller) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.hospitalName),
        actions: [
          IconButton(
            icon: Icon(Icons.account_balance_wallet),
            onPressed: () => navigator.to(InvestmentsPage()),
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => navigator.to(SettingsPage()),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOverviewCards(controller),
              SizedBox(height: 24),
              _buildQuickActions(controller),
              SizedBox(height: 24),
              _buildPatientProgress(controller),
              SizedBox(height: 24),
              _buildStatisticsSection(controller),
              SizedBox(height: 24),
              _buildWaitingPatientsList(controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewCards(DashboardBloc controller) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            'Balance',
            '\$${controller.balance}',
            Icons.account_balance_wallet,
            Colors.green,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
            'Patients',
            '${controller.waitingPatients.length}',
            Icons.people,
            Colors.blue,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
            'Staff',
            '${controller.totalDoctors + controller.totalNurses + controller.totalReceptionists}',
            Icons.medical_services,
            Colors.purple,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(DashboardBloc controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildActionButton(
              'Admit Next Patient',
              Icons.person_add,
              controller.waitingPatients.isNotEmpty
                  ? controller.admitNextPatient
                  : null,
              Colors.blue,
            ),
            _buildActionButton(
              'Discharge Ready',
              Icons.check_circle,
              controller.readyForDischarge.isNotEmpty
                  ? controller.dischargeReadyPatients
                  : null,
              Colors.green,
            ),
            _buildActionButton(
              'Generate Staff',
              Icons.group_add,
              controller.generateNewStaff,
              Colors.orange,
            ),
            _buildNavigationButton(
              'Register Patient',
              Icons.person_add_alt_1,
              () => navigator.to(PatientRegistrationPage()),
              Colors.teal,
            ),
            _buildNavigationButton(
              'Consultations',
              Icons.medical_information,
              () => navigator.to(ConsultationPage()),
              Colors.indigo,
            ),
            _buildNavigationButton(
              'Emergency Room',
              Icons.local_hospital,
              () => navigator.to(EmergencyRoomPage()),
              Colors.red,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
      String text, IconData icon, VoidCallback? onPressed, Color color) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: onPressed != null ? 4 : 0,
      ),
    );
  }

  Widget _buildNavigationButton(
      String text, IconData icon, VoidCallback onPressed, Color color) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
      ),
    );
  }

  Widget _buildPatientProgress(DashboardBloc controller) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.timer, color: Colors.blue[600], size: 24),
              SizedBox(width: 12),
              Text(
                'Next Patient Arrival',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[800],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: controller.remainingTimeForNextPatient,
              backgroundColor: Colors.blue[100],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsSection(DashboardBloc controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hospital Statistics',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Avg. Satisfaction',
                '${controller.averageSatisfaction.toStringAsFixed(1)}%',
                Icons.sentiment_satisfied,
                _getSatisfactionColor(controller.averageSatisfaction),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                'Avg. Wait Time',
                '${controller.averageWaitTime.inMinutes}m',
                Icons.access_time,
                _getWaitTimeColor(controller.averageWaitTime.inMinutes),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        _buildStaffAvailability(controller),
      ],
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffAvailability(DashboardBloc controller) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Staff Availability',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStaffIndicator(
                'Doctors',
                controller.availableDoctors,
                controller.totalDoctors,
                Colors.blue,
              ),
              _buildStaffIndicator(
                'Nurses',
                controller.availableNurses,
                controller.totalNurses,
                Colors.green,
              ),
              _buildStaffIndicator(
                'Reception',
                controller.availableReceptionists,
                controller.totalReceptionists,
                Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStaffIndicator(
      String role, int available, int total, Color color) {
    return Column(
      children: [
        Text(
          '$available/$total',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          role,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildWaitingPatientsList(DashboardBloc controller) {
    final patients = controller.waitingPatients.take(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Waiting Patients',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (controller.waitingPatients.length > 5)
              TextButton(
                onPressed: () => navigator.to(ManagedPatients()),
                child: Text('View All'),
              ),
          ],
        ),
        SizedBox(height: 8),
        if (patients.isEmpty)
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                'No patients waiting',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          )
        else
          ...patients.map((patient) => _buildPatientCard(patient)),
      ],
    );
  }

  Widget _buildPatientCard(Patient patient) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 6,
              height: 50,
              decoration: BoxDecoration(
                color: _getUrgencyColor(patient.urgency),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    patient.complaints,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.access_time,
                          size: 16, color: Colors.grey[500]),
                      SizedBox(width: 4),
                      Text(
                        'Waiting: ${patient.waitingTime.inMinutes}m',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getUrgencyColor(patient.urgency).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _getUrgencyColor(patient.urgency).withOpacity(0.3),
                ),
              ),
              child: Text(
                patient.urgency.name.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _getUrgencyColor(patient.urgency),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getSatisfactionColor(double satisfaction) {
    if (satisfaction >= 80) return Colors.green;
    if (satisfaction >= 60) return Colors.orange;
    return Colors.red;
  }

  Color _getWaitTimeColor(int minutes) {
    if (minutes <= 15) return Colors.green;
    if (minutes <= 30) return Colors.orange;
    return Colors.red;
  }

  Color _getUrgencyColor(UrgencyLevel urgency) {
    return switch (urgency) {
      UrgencyLevel.low => Colors.green,
      UrgencyLevel.medium => Colors.yellow,
      UrgencyLevel.high => Colors.orange,
      UrgencyLevel.critical => Colors.red,
    };
  }
}

// Keep existing Pages class
class Pages extends Feature<PagesBloc> {
  @override
  Widget build(BuildContext context, PagesBloc controller) {
    return PageView(
      children: [
        ReceiptsPage(),
        Dashboard(),
        ManagedPatients(),
        ReferredPatients(),
        UnsatisfiedPatientsPage(),
        AllStaffs(),
      ],
      onPageChanged: controller.onPageChanged,
    );
  }

  @override
  PagesBloc create() => PagesBloc();
}

class PagesBloc extends Bloc {
  final pageController = PageController();
  void onPageChanged(int index) {
    // react to page change
  }
}
