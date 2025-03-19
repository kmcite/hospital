import 'package:hospital/domain/models/facility.dart';
import 'package:hospital/domain/api/hospital_funds.dart';
import 'package:hospital/main.dart';

class Facilities extends ChangeNotifier {
  // ignore: unused_field
  final BuildContext _context;
  HospitalFunds get funds => _context.of();
  Facilities(this._context);

  Map<String, Facility> _facilities = {};
  Iterable<Facility> get facilities => _facilities.values;
  void put(Facility value) {
    _facilities[value.id] = value;
    notifyListeners();
  }

  int get availableFunds => funds.hospitalFunds;
  set availableFunds(int value) {
    funds.useHospitalFunds(value);
    notifyListeners();
  }

  Facility? getFacilityByName(String name) {
    return facilities.where((fac) => fac.name == name).firstOrNull;
  }

  bool upgradeFacility(String facilityName) {
    final facility = getFacilityByName(facilityName);
    if (facility != null && facility.canUpgrade(availableFunds)) {
      availableFunds -= facility.upgradeCost;
      facility.upgrade();
      put(facility);
      return true;
    }
    return false;
  }

  List<Map<String, dynamic>> getFacilityDetails() {
    return facilities.map(
      (facility) {
        return {
          'name': facility.name,
          'level': facility.currentLevel,
          'beds': facility.totalBeds,
          'nextUpgradeCost': facility.upgradeCost,
        };
      },
    ).toList();
  }
}
