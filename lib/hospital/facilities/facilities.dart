import 'package:hospital/hospital/facilities/facility.dart';
import 'package:hospital/hospital/finances/hospital_funds.dart';
import 'package:hospital/main.dart';

Facilities get facilities => facilitiesRM.state;
final facilitiesRM = RM.inject(() => Facilities());

class Facilities {
  final facilitiesRM = RM.inject(
    () => <String, Facility>{
      'icu': Facility(name: 'icu'),
    },
  );

  Map<String, Facility> get facilities => facilitiesRM.state;
  set facilities(Map<String, Facility> value) =>
      facilitiesRM.state = Map.of(value);
  double get availableFunds => funds.hospitalFunds;
  set availableFunds(double value) => funds.useHospitalFunds(value);

  Facility? getFacilityByName(String name) => facilities[name];

  bool upgradeFacility(String facilityName) {
    final facility = getFacilityByName(facilityName);
    if (facility != null && facility.canUpgrade(availableFunds)) {
      availableFunds -= facility.upgradeCost;
      facility.upgrade();
      facilities = Map.of(facilities)..[facility.name] = facility;
      return true;
    }
    return false;
  }

  List<Map<String, dynamic>> getFacilityDetails() {
    return facilities.values.map((facility) {
      return {
        'name': facility.name,
        'level': facility.currentLevel,
        'beds': facility.totalBeds,
        'nextUpgradeCost': facility.upgradeCost,
      };
    }).toList();
  }

  addFacility(Facility facility) {
    facilities = Map.of(facilities)..[facility.name] = facility;
  }
}
