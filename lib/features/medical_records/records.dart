import 'package:flutter/material.dart';
import 'package:hospital/domain/models/medical_record.dart';
import 'package:hospital/utils/context.dart';
import 'package:hospital/utils/navigator.dart';
import 'package:hospital/utils/notifier_provider.dart';

class RecordsNotifier extends ChangeNotifier {
  final BuildContext context;
  RecordsNotifier(this.context);

  /// dependencies
  late MedicalRecords recordsRepository = context.of();

  /// state
  late List<MedicalRecordModel> records = recordsRepository.getAll();
}

class RecordsView extends StatelessWidget {
  const RecordsView({super.key});
  @override
  Widget build(BuildContext context) {
    return NotifierProvider(
      create: RecordsNotifier.new,
      builder: (context, recordsNotifier) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Records'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: navigator.back,
            ),
          ),
          body: ListView.builder(
            itemCount: recordsNotifier.records.length,
            itemBuilder: (context, index) {
              final record = recordsNotifier.records[index];
              return ListTile(
                title: Text(record.toString()),
              );
            },
          ),
        );
      },
    );
  }
}
