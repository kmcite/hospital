import 'package:hospital/hospital/facilities/facilities_page.dart';
import 'package:hospital/hospital/hospital_page.dart';
import 'package:hospital/hospital/patients/admitted/admitted_patients_page.dart';
import 'package:hospital/hospital/patients/waiting/waiting_patients_page.dart';
import 'package:hospital/main.dart';
import 'package:icons_plus/icons_plus.dart';

final navigator = RM.navigate;

enum Pages {
  hospital(
    HospitalPage(),
    FontAwesome.hospital_solid,
    'Hospital',
  ),
  waiting(),

  admitted(
    AdmittedPatientsPage(),
    FontAwesome.affiliatetheme_brand,
    'Admitted Patients',
  ),
  facilities(
    FacilitiesPage(),
    FontAwesome.opencart_brand,
    'Facilities',
  );

  const Pages([
    this.page = const WaitingPatientsPage(),
    this.icon = FontAwesome.circle_info_solid,
    this.description = 'Waiting Patients',
  ]);
  final Widget page;
  final IconData icon;
  final String description;
}
