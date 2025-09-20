import 'package:hive_flutter/adapters.dart';
import 'package:hospital/features/hospital.dart';
import 'package:hospital/objectbox.g.dart' hide Box;
// import 'package:manager/architecture.dart' hide AppRunner, find, put;
import 'package:path_provider/path_provider.dart';
export 'package:flutter/material.dart';

import 'main.dart';
import 'repositories/balance_api.dart';
import 'repositories/generation_api.dart';
import 'repositories/investments_api.dart';
import 'repositories/medications_api.dart';
import 'repositories/patients_api.dart';
import 'repositories/receptions_api.dart';
import 'repositories/settings_api.dart';
import 'repositories/staff_api.dart';

export 'package:faker/faker.dart' hide Image, Color;
export 'package:hospital/utils/extensions.dart';
export 'package:hospital/main.dart' show print;
export 'package:hospital/utils/architecture.dart';
// export 'package:manager/extensions.dart';
// export 'package:manager/manager.dart' show navigator;

void main() {
  AppRunner(
    initialize: () async {
      /// object-box storage
      final path = await getApplicationDocumentsDirectory();
      final store = await openStore(directory: path.path);
      find<Store>(store);

      /// key-value storage
      await Hive.initFlutter();
      final box = await Hive.openBox<String>('storage');
      find(Storage(box));

      put(StaffRepository());
      put(PatientsRepository());
      put(SettingsRepository());
      put(BalanceRepository());
      put(GenerationRepository());
      put(InvestmentsRepository());
      put(ReceptionsRepository());
      put(MedicationsRepository());
    },
    app: HospitalView(),
  );
}

/// its hive_based storage system used key-value storage
class Storage {
  final Box<String> box;
  Storage(this.box);
  Future<void> save(String key, String value) async {
    await box.put(key, value);
  }

  String get(String key, {String defaultValue = ''}) {
    return box.get(key) ?? defaultValue;
  }
}
