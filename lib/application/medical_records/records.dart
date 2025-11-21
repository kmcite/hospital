import 'package:hospital/main.dart';

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
        return FScaffold(
          header: FHeader(
            title: Text('Records'),
            suffixes: [
              FHeaderAction.x(onPress: navigator.back),
            ],
          ),
          child: ListView.builder(
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
