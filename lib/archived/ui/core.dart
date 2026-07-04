// import 'package:flutter/material.dart';
// import 'package:hospital/archived/business/dark.dart';
// import 'package:hospital/archived/ui/admin/admin_office.dart';
// import 'package:hospital/archived/ui/doctor_room/doctor_room.dart';
// import 'package:hospital/archived/ui/hospital_flow/hospital_flow.dart';
// import 'package:hospital/archived/ui/minor_ot/minor_ot.dart';
// import 'package:hospital/archived/ui/ward/ward_room.dart';
// import 'package:hospital/managers/manager.dart';
// import 'package:provider/provider.dart';

// const fonts = 'SUSE Mono';
// final selectedAppSection = signal(0);

// class Core extends UI {
//   @override
//   Widget build(BuildContext context) {
//     final dark = context.read<DarkManager>();
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: .new(
//         fontFamily: fonts,
//       ),
//       darkTheme: .new(
//         fontFamily: fonts,
//         brightness: .dark,
//       ),
//       themeMode: dark.themeMode,
//       home: const HospitalShell(),
//     );
//   }
// }

// class HospitalShell extends UI {
//   const HospitalShell({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final index = selectedAppSection();

//     return Scaffold(
//       body: IndexedStack(
//         index: index,
//         children: const [
//           DoctorRoom(),
//           MinorOT(),
//           WardRoom(),
//           HospitalFlow(),
//           AdminOffice(),
//         ],
//       ),
//       bottomNavigationBar: NavigationBar(
//         selectedIndex: index,
//         onDestinationSelected: selectedAppSection.set,
//         destinations: const [
//           NavigationDestination(
//             icon: Icon(Icons.medical_services_outlined),
//             selectedIcon: Icon(Icons.medical_services),
//             label: 'Doctor',
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.healing_outlined),
//             selectedIcon: Icon(Icons.healing),
//             label: 'Minor OT',
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.hotel_outlined),
//             selectedIcon: Icon(Icons.hotel),
//             label: 'Ward',
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.account_tree_outlined),
//             selectedIcon: Icon(Icons.account_tree),
//             label: 'Flow',
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.admin_panel_settings_outlined),
//             selectedIcon: Icon(Icons.admin_panel_settings),
//             label: 'Admin',
//           ),
//         ],
//       ),
//     );
//   }
// }
