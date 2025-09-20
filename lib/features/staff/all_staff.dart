import 'package:flutter/foundation.dart';
import 'package:hospital/main.dart';
import 'package:hospital/models/staff/doctor.dart';
import 'package:hospital/repositories/staff_api.dart';
import 'package:hospital/utils/list_view.dart';
import 'package:hospital/utils/theme.dart';

import '../../models/staff/staff.dart';
import 'staff.dart';

_type(Type staff) {
  return switch (staff) { Staff => 'R', Doctor => 'D', _ => 'N' };
}

class AllStaffsBloc extends Bloc {
  late StaffRepository staffRepository = watch();

  Iterable<Staff> get staffs => staffRepository.getAll();
  bool get isGenerating => staffRepository.isGenerating;

  void toggleGeneration() {
    staffRepository.toggleGeneration();
  }
}

class AllStaffs extends Feature<AllStaffsBloc> {
  @override
  create() => AllStaffsBloc();

  @override
  Widget build(BuildContext context, AllStaffsBloc controller) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Staffs',
        ),
        actions: [
          IconButton(
            icon: Icon(
              controller.isGenerating ? Icons.pause : Icons.play_arrow,
            ),
            onPressed: controller.toggleGeneration,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(HospitalTheme.defaultPadding),
        child: listView(
          controller.staffs,
          (staff) {
            return Container(
              margin: EdgeInsets.only(bottom: HospitalTheme.smallSpacing),
              child: Card(
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _getStaffTypeColor(staff.runtimeType)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        _type(staff.runtimeType),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _getStaffTypeColor(staff.runtimeType),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    staff.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: HospitalTheme.smallSpacing),
                      Row(
                        children: [
                          _buildStatusIndicator('Working', staff.isWorking,
                              HospitalTheme.primaryColor),
                          SizedBox(width: HospitalTheme.mediumSpacing),
                          _buildStatusIndicator('Resting', staff.isResting,
                              HospitalTheme.successColor),
                          SizedBox(width: HospitalTheme.mediumSpacing),
                          _buildStatusIndicator('Exhausted', staff.isExhausted,
                              HospitalTheme.errorColor),
                        ],
                      ),
                      SizedBox(height: HospitalTheme.smallSpacing),
                      Row(
                        children: [
                          Text(
                            'Energy:',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(width: HospitalTheme.smallSpacing),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: clampDouble(staff.energyLevel, 0, 1),
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                _getEnergyColor(staff.energyLevel),
                              ),
                            ),
                          ),
                          SizedBox(width: HospitalTheme.smallSpacing),
                          Text(
                            '${(staff.energyLevel * 100).toInt()}%',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: _getEnergyColor(staff.energyLevel),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey[400],
                  ),
                  onTap: () => navigator.to(StaffPage(staff: staff)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(String label, bool value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: value ? color : Colors.grey[300],
          ),
        ),
        SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: value ? color : Colors.grey[600],
            fontWeight: value ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Color _getStaffTypeColor(Type staffType) {
    return switch (staffType) {
      const (Doctor) => HospitalTheme.primaryColor,
      _ => HospitalTheme.successColor, // Nurse and other staff
    };
  }

  Color _getEnergyColor(double energyLevel) {
    if (energyLevel >= 0.7) return HospitalTheme.successColor;
    if (energyLevel >= 0.4) return HospitalTheme.warningColor;
    return HospitalTheme.errorColor;
  }
}
