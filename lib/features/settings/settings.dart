import 'package:hospital/features/medications/medications.dart';
import 'package:hospital/features/settings/ambulance_fee_modification_dialog.dart';
import 'package:hospital/main.dart';
import 'package:hospital/repositories/generation_api.dart';
import 'package:hospital/utils/theme.dart';

import '../../repositories/settings_api.dart';

class SettingsBloc extends Bloc {
  /// SOURCES
  late final SettingsRepository settingsRepository = watch();
  late final GenerationRepository generationRepository = watch();

  String get ambulanceFeesString {
    return settingsRepository.ambulanceFees.toStringAsFixed(0);
  }

  String get hospitalName => settingsRepository.hospitalName;
  bool get dark => settingsRepository.dark;

  /// MUTATIONS
  late final setHospitalName = settingsRepository.setHospitalName;
  late final toggleDark = settingsRepository.toggleDark;
  void clearUnsatisfiedPatients() {
    generationRepository.unsatisfiedPatients.clear();
  }
}

class SettingsPage extends Feature<SettingsBloc> {
  @override
  create() => SettingsBloc();

  @override
  Widget build(BuildContext context, controller) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => navigator.back(),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(HospitalTheme.defaultPadding),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(HospitalTheme.cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Actions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: HospitalTheme.mediumSpacing),
                    Wrap(
                      spacing: HospitalTheme.smallSpacing,
                      runSpacing: HospitalTheme.smallSpacing,
                      children: [
                        _buildActionChip(
                          controller.dark ? 'Dark Mode' : 'Light Mode',
                          controller.dark ? Icons.dark_mode : Icons.light_mode,
                          controller.toggleDark,
                          HospitalTheme.primaryColor,
                        ),
                        _buildActionChip(
                          'Ambulance Fees',
                          Icons.edit,
                          () => navigator
                              .toDialog(AmbulanceFeeModificationDialog()),
                          HospitalTheme.warningColor,
                        ),
                        _buildActionChip(
                          'Clear Unsatisfied',
                          Icons.delete,
                          controller.clearUnsatisfiedPatients,
                          HospitalTheme.errorColor,
                        ),
                        _buildActionChip(
                          'Medications',
                          Icons.medical_information,
                          () => navigator.to(MedicationsPage()),
                          HospitalTheme.successColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: HospitalTheme.mediumSpacing),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: HospitalTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        controller.dark ? Icons.dark_mode : Icons.light_mode,
                        color: HospitalTheme.primaryColor,
                      ),
                    ),
                    title: Text(
                      'Theme Mode',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(controller.dark ? 'Dark' : 'Light'),
                    trailing: Switch(
                      value: controller.dark,
                      onChanged: (_) => controller.toggleDark(),
                      activeColor: HospitalTheme.primaryColor,
                    ),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: HospitalTheme.warningColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.local_taxi,
                        color: HospitalTheme.warningColor,
                      ),
                    ),
                    title: Text(
                      'Ambulance Fees',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text('\$${controller.ambulanceFeesString}'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () =>
                        navigator.toDialog(AmbulanceFeeModificationDialog()),
                  ),
                ],
              ),
            ),
            SizedBox(height: HospitalTheme.mediumSpacing),
            Card(
              child: Padding(
                padding: EdgeInsets.all(HospitalTheme.cardPadding),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Hospital Name',
                    helperText: 'Customize your hospital name',
                    prefixIcon: Icon(Icons.local_hospital),
                  ),
                  onChanged: controller.setHospitalName,
                  controller:
                      TextEditingController(text: controller.hospitalName),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionChip(
      String label, IconData icon, VoidCallback onTap, Color color) {
    return ActionChip(
      avatar: Icon(icon, color: color, size: 18),
      label: Text(label),
      onPressed: onTap,
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide(color: color.withOpacity(0.3)),
      labelStyle: TextStyle(
        color: color,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
