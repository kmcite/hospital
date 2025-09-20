// import 'package:forui/forui.dart'; // Removed - using Material Design
import 'package:hospital/main.dart';
import 'package:hospital/repositories/settings_api.dart';

class AmbulanceFeeModificationBloc extends Bloc {
  late final SettingsRepository settingsRepository = watch();

  /// GLOBAL STATE
  double get ambulaceFees => settingsRepository.ambulanceFees;
  set ambulaceFees(double value) => settingsRepository.setAmbulanceFees(value);

  final minimumFees = 0.0;
  final maximumFees = 300.0;

  /// LOCAL STATE
  late double currentFees = ambulaceFees;

  void onCurrentFeesChanged(double value) {
    currentFees = value;
    notifyListeners();
  }

  void onSaved() {
    ambulaceFees = currentFees;
    navigator.back();
  }

  void onCancelled() {
    navigator.back();
  }
}

class AmbulanceFeeModificationDialog
    extends Feature<AmbulanceFeeModificationBloc> {
  @override
  AmbulanceFeeModificationBloc create() => AmbulanceFeeModificationBloc();
  @override
  Widget build(context, controller) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Ambulance Fees',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Set the fees for ambulance service.'),
            SizedBox(height: 16),
            Chip(
              label: Text(
                '${controller.currentFees.ceil()}\n${controller.ambulaceFees.ceil()}',
              ),
            ),
            SizedBox(height: 16),
            Slider(
              min: controller.minimumFees,
              max: controller.maximumFees,
              value: controller.currentFees,
              onChanged: controller.onCurrentFeesChanged,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: controller.onSaved,
                  child: Text('Save'),
                ),
                SizedBox(width: 8),
                TextButton(
                  onPressed: controller.onCancelled,
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
