import 'package:hospital/application/departments/doctor_room/doctor_room.dart';
import 'package:hospital/application/departments/staff_room/hire_staff.dart';
import 'package:hospital/application/departments/staff_room/staff_list.dart';
import 'package:hospital/main.dart';

///  │       ├── StaffRoomView
///  │       │   ├── Staff List
///  │       │   │   ├── Role Icon
///  │       │   │   ├── Efficiency Bar
///  │       │   │   ├── Salary Display
///  │       │   │   └── FIRE button
///  │       │   ├── Hire Staff
///  │       │   └── Payroll Summary

enum StaffActivity { sleeping, working, chilling }

class StaffsNotifier extends Notifier {
  StaffsNotifier(super.context);

  late final Staffs staffs = context.of();

  bool loading = false;
  String message = '';
  List<StaffModel> listOfStaffs = [];

  StaffActivity currentActivity = StaffActivity.sleeping;

  Future<void> loadStaff() async {
    loading = true;
    notifyListeners();
    try {
      listOfStaffs = staffs.getAll();
    } catch (e) {
      message = 'Failed to load staff: $e';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> onStaffAdded(StaffModel staff) async {
    loading = true;
    notifyListeners();
    try {
      staffs.put(staff);
      await loadStaff();
    } catch (e) {
      message = 'Failed to add staff: $e';
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}

class StaffRoom extends StatelessTab {
  const StaffRoom({super.key});
  @override
  String get name => 'Staff Room';

  @override
  Widget build(BuildContext context) {
    return NotifierProvider(
      create: StaffsNotifier.new,
      builder: (context, staffsNotifier) {
        return SizedBox(
          height: MediaQuery.sizeOf(context).height - 133,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Hospital Staff'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    staffsNotifier.loadStaff();
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
            body: staffsNotifier.loading
                ? CircularProgressIndicator()
                : StaffList(staff: staffsNotifier.listOfStaffs),
            floatingActionButton: FloatingActionButton(
              onPressed: () => navigator.toDialog(
                HireStaffDialog(onAddStaff: staffsNotifier.onStaffAdded),
              ),
              child: const Icon(Icons.person_add),
            ),
          ),
        );
      },
    );
  }
}
