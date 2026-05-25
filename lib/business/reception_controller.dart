import 'package:hospital/api/receptionist.dart';

class ReceptionistsState {
  Map<String, Receptionist> cache = {};
  Receptionist? current;
  bool isCounterOpen = true;
  int get staffCount => cache.length;
  Map<String, Receptionist> get receptionists => Map.unmodifiable(cache);
  List<Receptionist> get listOfReceptionists =>
      cache.values.toList()..sort((a, b) => b.hiredDate.compareTo(a.hiredDate));

  int get onDutyCount =>
      cache.values.where((r) => r.isOnDuty && !r.isExhausted).length;
  double get averageEfficiency {
    if (cache.isEmpty) return 0;
    return cache.values.map((r) => r.efficiency).reduce((a, b) => a + b) /
        cache.length;
  }

  List<Receptionist> get availableStaff =>
      cache.values.where((r) => !r.isOnDuty && !r.isExhausted).toList();
}

// class ReceptionController extends ChangeNotifier {
//   final Map<String, Receptionist> _receptionists = {};
//   String? _activeReceptionistId;
//   bool _counterOpen = true;
//   Timer? _serviceTimer;
//   Timer? _autoSaveTimer;

//   // Getters

//   // Receptionist? get activeReceptionist {
//   //   if (_activeReceptionistId == null) return null;
//   //   return _receptionists[_activeReceptionistId];
//   // }

//   // bool get counterOpen => _counterOpen;

//   // Initialize controller
//   ReceptionController() {
//     _startServiceTimer();
//     _startAutoSave();
//   }

//   void _startServiceTimer() {
//     _serviceTimer?.cancel();
//     _serviceTimer = Timer.periodic(const Duration(seconds: 2), (_) {
//       if (_counterOpen &&
//           activeReceptionist != null &&
//           !activeReceptionist!.isExhausted) {
//         activeReceptionist!.provideService();

//         // Auto-assign new receptionist if current one is exhausted
//         if (activeReceptionist!.isExhausted) {
//           _assignNextAvailable();
//         }

//         notifyListeners();
//       }
//     });
//   }

//   void _startAutoSave() {
//     _autoSaveTimer = Timer.periodic(const Duration(minutes: 5), (_) {
//       // Implement auto-save logic here if needed
//       debugPrint('Auto-saving reception data...');
//     });
//   }

//   // Staff management
//   String? recruitReceptionist({String? customName}) {
//     try {
//       final receipt = adminController.requestMoney(
//         2500,
//         reason: 'Recruiting new receptionist',
//       );

//       if (receipt == null) {
//         throw Exception('Failed to process recruitment payment');
//       }

//       final receptionist = Receptionist(
//         id: faker.guid.guid(),
//         name: customName ?? faker.person.name(),
//       );

//       _receptionists[receptionist.id] = receptionist;

//       // Auto-assign if no one is on duty
//       if (_counterOpen && activeReceptionist == null) {
//         _assignOnDuty(receptionist.id);
//       }

//       notifyListeners();
//       return receptionist.id;
//     } catch (e) {
//       debugPrint('Recruitment failed: $e');
//       rethrow;
//     }
//   }

//   void _assignOnDuty(String id) {
//     final receptionist = _receptionists[id];
//     if (receptionist == null || receptionist.isExhausted) return;

//     // Remove current active receptionist
//     if (_activeReceptionistId != null) {
//       final current = _receptionists[_activeReceptionistId];
//       if (current != null) {
//         current.isOnDuty = false;
//       }
//     }

//     receptionist.isOnDuty = true;
//     _activeReceptionistId = id;
//   }

//   void assignOnDuty(String id) {
//     if (!_counterOpen) {
//       throw StateError('Cannot assign staff when counter is closed');
//     }

//     final receptionist = _receptionists[id];
//     if (receptionist == null) {
//       throw StateError('Receptionist not found');
//     }

//     if (receptionist.isExhausted) {
//       throw StateError('${receptionist.name} is exhausted and needs rest');
//     }

//     _assignOnDuty(id);
//     notifyListeners();
//   }

//   void removeFromDuty() {
//     if (_activeReceptionistId != null) {
//       final current = _receptionists[_activeReceptionistId];
//       if (current != null) {
//         current.isOnDuty = false;
//       }
//       _activeReceptionistId = null;
//       notifyListeners();
//     }
//   }

//   void _assignNextAvailable() {
//     final available = availableStaff;
//     if (available.isNotEmpty) {
//       _assignOnDuty(available.first.id);
//     }
//   }

//   // Rest management
//   void sendForRest(String id) {
//     final receptionist = _receptionists[id];
//     if (receptionist == null) return;

//     receptionist.rest();

//     if (_activeReceptionistId == id) {
//       _activeReceptionistId = null;
//       _assignNextAvailable();
//     }

//     notifyListeners();
//   }

//   void restAllStaff() {
//     for (final receptionist in _receptionists.values) {
//       receptionist.rest();
//     }
//     _activeReceptionistId = null;
//     _assignNextAvailable();
//     notifyListeners();
//   }

//   // Financial operations
//   void rewardMoney(int amount) {
//     if (amount <= 0) {
//       throw ArgumentError('Amount must be greater than 0');
//     }

//     adminController.sourceFunds(
//       amount,
//       source: 'Reception department funding',
//     );
//     notifyListeners();
//   }

//   void fireReceptionist(String id) {
//     final receptionist = _receptionists[id];
//     if (receptionist == null) return;

//     // Severance pay
//     final severancePay = 500;
//     adminController.sourceFunds(
//       severancePay,
//       source: 'Severance pay for ${receptionist.name}',
//     );

//     if (_activeReceptionistId == id) {
//       _activeReceptionistId = null;
//       _assignNextAvailable();
//     }

//     _receptionists.remove(id);
//     notifyListeners();
//   }

//   // Statistics
//   Map<String, dynamic> getStatistics() {
//     return {
//       'totalStaff': staffCount,
//       'onDuty': onDutyCount,
//       'exhausted': _receptionists.values.where((r) => r.isExhausted).length,
//       'averageEfficiency': (averageEfficiency * 100).toStringAsFixed(1),
//       'totalPatientsServed': _receptionists.values.fold(
//         0,
//         (sum, r) => sum + r.patientsServed,
//       ),
//       'counterStatus': _counterOpen ? 'Open' : 'Closed',
//     };
//   }

//   @override
//   void dispose() {
//     _serviceTimer?.cancel();
//     _autoSaveTimer?.cancel();
//     super.dispose();
//   }
// }
