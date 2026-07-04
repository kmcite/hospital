// import 'package:flutter/material.dart';
// import 'package:hospital/archived/business/patients.dart';
// import 'package:hospital/archived/business/staffing.dart';
// import 'package:hospital/archived/ui/shared/panel_card.dart';
// import 'package:hospital/archived/ui/shared/status_badge.dart';
// import 'package:hospital/managers/manager.dart';

// class ConsultationPanel extends UI {
//   const ConsultationPanel({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final hasPatient = activePatient() != null;
//     final doctorReady = isDoctorRoomFunctional();

//     return PanelCard(
//       title: 'ConsultationSystem',
//       icon: Icons.medical_services_outlined,
//       child: ListView(
//         children: [
//           AnimatedContainer(
//             duration: const Duration(milliseconds: 240),
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: hasPatient
//                   ? Theme.of(context).colorScheme.primaryContainer.withValues(
//                       alpha: 0.45,
//                     )
//                   : Theme.of(context).colorScheme.surfaceContainerHighest,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: hasPatient
//                 ? _ActivePatientCard()
//                 : const _EmptyConsultation(),
//           ),
//           SizedBox(height: 8),
//           Wrap(
//             spacing: 8,
//             runSpacing: 8,
//             children: [
//               _ConsultationAction(
//                 icon: Icons.login_outlined,
//                 label: 'Call Next',
//                 onPressed: !doctorReady || hasPatient || waitingPatients.isEmpty
//                     ? null
//                     : callNextPatient,
//               ),
//               _ConsultationAction(
//                 icon: Icons.healing_outlined,
//                 label: 'Refer Minor OT',
//                 onPressed: doctorReady && hasPatient
//                     ? referActivePatientToMinorOt
//                     : null,
//               ),
//               _ConsultationAction(
//                 icon: Icons.local_hospital,
//                 label: 'Refer OPD',
//                 onPressed: doctorReady && hasPatient
//                     ? referActivePatientToOpd
//                     : null,
//               ),
//               _ConsultationAction(
//                 icon: Icons.hotel,
//                 label: 'Refer Ward',
//                 onPressed: doctorReady && hasPatient
//                     ? referActivePatientToWard
//                     : null,
//               ),
//               _ConsultationAction(
//                 icon: Icons.home_outlined,
//                 label: 'Discharge Home',
//                 onPressed: doctorReady && hasPatient
//                     ? dischargeActivePatientHome
//                     : null,
//               ),
//               _ConsultationAction(
//                 icon: Icons.local_hospital,
//                 label: 'Refer BKMC/MTI',
//                 onPressed: doctorReady && hasPatient
//                     ? referActivePatientToBkmc
//                     : null,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _ActivePatientCard extends UI {
//   const _ActivePatientCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final patient = activePatient()!;
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         CircleAvatar(
//           radius: 36,
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           child: const Icon(
//             Icons.personal_injury_outlined,
//             color: Colors.white,
//             size: 34,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Text(
//           patient.name,
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//             fontWeight: FontWeight.w900,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           patient.concern,
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.titleMedium?.copyWith(
//             color: Theme.of(context).colorScheme.onSurfaceVariant,
//           ),
//         ),
//         const SizedBox(height: 18),
//         _FeeBadge(fee: patient.fee),
//         if (patient.requiresMinorOtCare) ...[
//           const SizedBox(height: 12),
//           const Center(
//             child: StatusBadge(
//               icon: Icons.healing_outlined,
//               label: 'Needs Minor OT care',
//               alert: true,
//             ),
//           ),
//         ],
//         if (patient.requiresNursingCare) ...[
//           const SizedBox(height: 12),
//           const Center(
//             child: StatusBadge(
//               icon: Icons.vaccines_outlined,
//               label: 'Needs nursing care',
//               alert: true,
//             ),
//           ),
//         ],
//       ],
//     );
//   }
// }

// class _ConsultationAction extends StatelessWidget {
//   const _ConsultationAction({
//     required this.icon,
//     required this.label,
//     required this.onPressed,
//   });

//   final IconData icon;
//   final String label;
//   final VoidCallback? onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton.icon(
//       onPressed: onPressed,
//       icon: Icon(icon, size: 20),
//       label: Text(label, overflow: TextOverflow.ellipsis),
//     );
//   }
// }

// class _EmptyConsultation extends StatelessWidget {
//   const _EmptyConsultation();

//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       spacing: 8,
//       runSpacing: 8,
//       children: [
//         Icon(
//           Icons.event_seat_outlined,
//           size: 54,
//           color: Theme.of(context).colorScheme.onSurfaceVariant,
//         ),
//         // const SizedBox(height: 14),
//         Text(
//           'No patient in consultation',
//           textAlign: TextAlign.start,
//           style: Theme.of(context).textTheme.titleLarge?.copyWith(
//             fontWeight: FontWeight.w800,
//           ),
//         ),
//         Text(
//           'Call the next patient from the waiting queue.',
//           textAlign: TextAlign.start,
//           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//             color: Theme.of(context).colorScheme.onSurfaceVariant,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _FeeBadge extends StatelessWidget {
//   const _FeeBadge({required this.fee});

//   final int fee;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//         decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.surface,
//           borderRadius: BorderRadius.circular(999),
//           border: Border.all(
//             color: Theme.of(context).colorScheme.outlineVariant,
//           ),
//         ),
//         child: Text(
//           'Consultation fee: Rs. $fee',
//           style: Theme.of(context).textTheme.labelLarge?.copyWith(
//             fontWeight: FontWeight.w800,
//           ),
//         ),
//       ),
//     );
//   }
// }
