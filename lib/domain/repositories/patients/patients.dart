// import 'dart:async';
// import 'dart:math' show Random;
// import 'dart:developer' as developer;

// import 'package:hospital/api/faker.dart';

// import '../../main.dart';
// import '../../models/patient.dart';

// final patientsRepository = PatientsRepository();

// class PatientsRepository extends CRUD<Patient> {
//   PatientsRepository() {
//     startAdditionTimer();
//     startRemovalTimer();
//     startPatientUpdateTimer(); // Start the new timer
//   }

//   dispose() async {
//     stopAdditionTimer();
//     stopPatientUpdateTimer(); // Stop the new timer
//     super.dispose();
//   }

//   final random = Random();
//   Timer? _additionTimer;
//   Timer? _countdownTimer;
//   Timer? _patientUpdateTimer; // New timer for updating patients
//   final Random _random = Random();
//   DateTime? _nextAdditionTime;
//   final remainingTimeForNextPatientRM = RM.inject(() => 0);
//   int ticksSinceStart = 0;
//   bool isTimerRunning = false;
//   int maxWaitingPatients = 10;

//   int get remainingTimeForNextPatient => remainingTimeForNextPatientRM.state;

//   void startAdditionTimer() {
//     isTimerRunning = true;
//     _scheduleNextAddition();
//     _startCountdownTimer();
//   }

//   void stopAdditionTimer() {
//     _additionTimer?.cancel();
//     _countdownTimer?.cancel();
//     _nextAdditionTime = null;
//     isTimerRunning = false;
//   }

//   void _scheduleNextAddition() {
//     final duration = Duration(seconds: _random.nextInt(10) + 5);
//     _nextAdditionTime = DateTime.now().add(duration);
//     remainingTimeForNextPatientRM.state = duration.inSeconds;

//     _additionTimer = Timer(
//       duration,
//       () {
//         ticksSinceStart++;
//         addPatient();
//         _scheduleNextAddition(); // Restart the timer
//       },
//     );
//   }

//   void _startCountdownTimer() {
//     _countdownTimer = Timer.periodic(
//       Duration(seconds: 1),
//       (_) {
//         if (_nextAdditionTime == null) {
//           remainingTimeForNextPatientRM.state = 0;
//           return;
//         }
//         final remaining = _nextAdditionTime!.difference(DateTime.now());
//         remainingTimeForNextPatientRM.state =
//             remaining.isNegative ? 0 : remaining.inSeconds;
//       },
//     );
//   }

//   Patient generatePatient() {
//     final urgencyLevels = Urgency.values;
//     final randomUrgency = urgencyLevels[_random.nextInt(urgencyLevels.length)];

//     return Patient(
//       name: faker.person.name(), // Generate a random name
//       remainingTime:
//           _random.nextInt(30) + 10, // Random time between 10 and 40 seconds
//       canPay: _random.nextBool(), // Randomly decide if the patient can pay
//       satisfaction:
//           _random.nextDouble() * 100, // Random satisfaction between 0 and 100
//       urgency: randomUrgency, // Random urgency level
//       // status: Status.waiting, // Default status is 'waiting'
//     );
//   }

//   void addPatient() {
//     if (getByStatus(Status.waiting).length >= maxWaitingPatients) {
//       developer.log('Maximum waiting patients reached.',
//           name: 'PatientsRepository');
//       return;
//     }
//     final patient = generatePatient();
//     put(patient);
//     developer.log('Added new patient: ${patient.name}',
//         name: 'PatientsRepository');
//   }

//   Iterable<Patient> getByStatus([
//     Status status = Status.waiting,
//   ]) {
//     return getAll().where(
//       (patient) => patient.status == status,
//     );
//   }

//   void startRemovalTimer() {
//     Timer.periodic(
//       Duration(minutes: 2),
//       removeTreatedPatients,
//     );
//   }

//   void removeTreatedPatients(_) {
//     final treatedPatients = getByStatus(Status.discharged);
//     for (final patient in treatedPatients) {
//       remove(patient.id);
//       developer.log(
//         'Removed treated patient: ${patient.name}',
//         name: 'PatientsRepository',
//       );
//     }
//   }

//   // New Timer for Updating Patients
//   void startPatientUpdateTimer() {
//     _patientUpdateTimer = Timer.periodic(
//       Duration(seconds: 1), // Update every second
//       (_) {
//         final patients = getAll().toList();
//         for (final patient in patients) {
//           if (patient.remainingTime > 0) {
//             patient.remainingTime -= 1; // Decrease remaining time
//             developer.log(
//               'Updated patient: ${patient.name}, Remaining Time: ${patient.remainingTime}',
//               name: 'PatientsRepository',
//             );
//             if (patient.remainingTime == 0) {
//               // Handle patient leaving or dying
//               patient.status = Status.discharged; // Example: Mark as discharged
//               developer.log(
//                 'Patient ${patient.name} has left or died.',
//                 name: 'PatientsRepository',
//               );
//             }
//           }
//         }
//       },
//     );
//   }

//   void stopPatientUpdateTimer() {
//     _patientUpdateTimer?.cancel();
//   }
// }
