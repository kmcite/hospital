import 'package:hospital/main.dart';
import 'package:hospital/models/patient.dart';
import 'package:hospital/repositories/patients_api.dart';
import 'package:hospital/utils/theme.dart';

class PatientRegistrationBloc extends Bloc {
  late final PatientsRepository patientsRepository = watch();

  final nameController = TextEditingController();
  final complaintsController = TextEditingController();
  final phoneController = TextEditingController();
  final emergencyContactController = TextEditingController();
  final addressController = TextEditingController();

  UrgencyLevel selectedUrgency = UrgencyLevel.low;
  bool isInsured = false;
  int age = 25;
  String selectedGender = 'Male';

  final genders = ['Male', 'Female', 'Other'];

  void setUrgency(UrgencyLevel urgency) {
    selectedUrgency = urgency;
    notifyListeners();
  }

  void setInsurance(bool value) {
    isInsured = value;
    notifyListeners();
  }

  void setAge(double value) {
    age = value.round();
    notifyListeners();
  }

  void setGender(String gender) {
    selectedGender = gender;
    notifyListeners();
  }

  void registerPatient() {
    if (nameController.text.isEmpty || complaintsController.text.isEmpty) {
      // Show error
      return;
    }

    // ignore: unused_local_variable
    final patient = patientsRepository.createPatient(
      name: nameController.text,
      complaints: complaintsController.text,
      urgency: selectedUrgency,
      isInsured: isInsured,
    );

    // Clear form
    nameController.clear();
    complaintsController.clear();
    phoneController.clear();
    emergencyContactController.clear();
    addressController.clear();
    selectedUrgency = UrgencyLevel.low;
    isInsured = false;
    age = 25;
    selectedGender = 'Male';
    notifyListeners();

    navigator.back();
  }

  @override
  void dispose() {
    nameController.dispose();
    complaintsController.dispose();
    phoneController.dispose();
    emergencyContactController.dispose();
    addressController.dispose();
    super.dispose();
  }
}

class PatientRegistrationPage extends Feature<PatientRegistrationBloc> {
  @override
  PatientRegistrationBloc create() => PatientRegistrationBloc();

  @override
  Widget build(BuildContext context, PatientRegistrationBloc controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Registration'),
        actions: [
          TextButton(
            onPressed: controller.registerPatient,
            child: const Text('Register'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(HospitalTheme.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Patient Information Section
            _buildSectionTitle('Patient Information'),
            const SizedBox(height: HospitalTheme.mediumSpacing),

            TextField(
              controller: controller.nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name *',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: HospitalTheme.mediumSpacing),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Age: ${controller.age}',
                          style: Theme.of(context).textTheme.labelLarge),
                      Slider(
                        value: controller.age.toDouble(),
                        min: 0,
                        max: 100,
                        divisions: 100,
                        onChanged: controller.setAge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: HospitalTheme.mediumSpacing),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: controller.selectedGender,
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      prefixIcon: Icon(Icons.wc),
                    ),
                    items: controller.genders.map((gender) {
                      return DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (value) => controller.setGender(value!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: HospitalTheme.mediumSpacing),

            TextField(
              controller: controller.phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: HospitalTheme.mediumSpacing),

            TextField(
              controller: controller.addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                prefixIcon: Icon(Icons.home),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: HospitalTheme.largeSpacing),

            // Medical Information Section
            _buildSectionTitle('Medical Information'),
            const SizedBox(height: HospitalTheme.mediumSpacing),

            TextField(
              controller: controller.complaintsController,
              decoration: const InputDecoration(
                labelText: 'Chief Complaints *',
                prefixIcon: Icon(Icons.medical_information),
                hintText: 'Describe the main symptoms or concerns',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: HospitalTheme.mediumSpacing),

            TextField(
              controller: controller.emergencyContactController,
              decoration: const InputDecoration(
                labelText: 'Emergency Contact',
                prefixIcon: Icon(Icons.emergency),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: HospitalTheme.largeSpacing),

            // Urgency and Insurance Section
            _buildSectionTitle('Priority & Insurance'),
            const SizedBox(height: HospitalTheme.mediumSpacing),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(HospitalTheme.cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Urgency Level',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: HospitalTheme.smallSpacing),
                    Wrap(
                      spacing: HospitalTheme.smallSpacing,
                      children: UrgencyLevel.values.map((urgency) {
                        final isSelected =
                            controller.selectedUrgency == urgency;
                        return ChoiceChip(
                          label: Text(urgency.name.toUpperCase()),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) controller.setUrgency(urgency);
                          },
                          backgroundColor:
                              HospitalTheme.getUrgencyColor(urgency.name)
                                  .withOpacity(0.1),
                          selectedColor:
                              HospitalTheme.getUrgencyColor(urgency.name)
                                  .withOpacity(0.3),
                          labelStyle: TextStyle(
                            color: HospitalTheme.getUrgencyColor(urgency.name),
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: HospitalTheme.mediumSpacing),

            Card(
              child: SwitchListTile(
                title: const Text('Has Insurance'),
                subtitle: const Text('Patient has medical insurance coverage'),
                value: controller.isInsured,
                onChanged: controller.setInsurance,
                secondary: const Icon(Icons.health_and_safety),
              ),
            ),

            const SizedBox(height: HospitalTheme.extraLargeSpacing),

            // Register Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: controller.registerPatient,
                icon: const Icon(Icons.person_add),
                label: const Text('Register Patient'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(HospitalTheme.mediumSpacing),
                  backgroundColor: HospitalTheme.primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: HospitalTheme.primaryColor,
      ),
    );
  }
}
