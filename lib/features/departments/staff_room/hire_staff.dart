import 'package:flutter/material.dart';
import 'package:hospital/domain/models/staff.dart';
import 'package:hospital/utils/navigator.dart';
import 'package:hospital/utils/notifier.dart';
import 'package:hospital/utils/notifier_provider.dart';

class HireStaffNotifier extends Notifier {
  HireStaffNotifier(super.context);

  String name = '';
  String role = 'doctor';
  String department = '';
  String contact = '';
  String email = '';

  void onNameChanged(String name) {
    this.name = name;
    notifyListeners();
  }

  void onRoleChanged(String role) {
    this.role = role;
    notifyListeners();
  }

  void onDepartmentChanged(String department) {
    this.department = department;
    notifyListeners();
  }

  void onContactChanged(String contact) {
    this.contact = contact;
    notifyListeners();
  }

  void onEmailChanged(String email) {
    this.email = email;
    notifyListeners();
  }

  Future<void> addStaff(Future<void> Function(StaffModel) onAddStaff) async {
    if (name.isNotEmpty &&
        department.isNotEmpty &&
        contact.isNotEmpty &&
        email.isNotEmpty) {
      final staff = StaffModel(
        name: name,
        role: role,
        department: department,
        contactNumber: contact,
        email: email,
      );

      await onAddStaff(staff);
      navigator.back();
    }
  }
}

class HireStaffDialog extends StatelessWidget {
  final Future<void> Function(StaffModel) onAddStaff;

  const HireStaffDialog({super.key, required this.onAddStaff});

  @override
  Widget build(BuildContext context) {
    return NotifierProvider<HireStaffNotifier>(
      create: HireStaffNotifier.new,
      builder: (context, notifier) {
        return AlertDialog(
          title: const Text('Add New Staff Member'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: notifier.name,
                onChanged: notifier.onNameChanged,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: notifier.role,
                items:
                    [
                      'doctor',
                      'nurse',
                      'receptionist',
                      'administrator',
                      'other',
                    ].map(
                      (role) {
                        return DropdownMenuItem(
                          value: role,
                          child: Text(role),
                        );
                      },
                    ).toList(),
                onChanged: (value) {
                  if (value != null) {
                    notifier.onRoleChanged(value);
                  }
                },
                decoration: const InputDecoration(labelText: 'Role'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: notifier.department,
                onChanged: notifier.onDepartmentChanged,
                decoration: const InputDecoration(labelText: 'Department'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: notifier.contact,
                decoration: const InputDecoration(labelText: 'Contact Number'),
                keyboardType: TextInputType.phone,
                onChanged: notifier.onContactChanged,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: notifier.email,
                onChanged: notifier.onEmailChanged,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                navigator.back();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => notifier.addStaff(onAddStaff),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
