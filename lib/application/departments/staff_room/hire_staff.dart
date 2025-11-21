import 'package:hospital/main.dart';

class HireStaffDialog extends StatefulWidget {
  const HireStaffDialog({super.key, required this.onAddStaff});
  final Future<void> Function(StaffModel) onAddStaff;

  @override
  State<HireStaffDialog> createState() => _HireStaffDialogState();
}

class _HireStaffDialogState extends State<HireStaffDialog> {
  String name = '';
  String role = 'doctor';
  String department = '';
  String contact = '';
  String email = '';

  void onNameChanged(String name) {
    setState(() => this.name = name);
  }

  void onRoleChanged(String role) {
    setState(() => this.role = role);
  }

  void onDepartmentChanged(String department) {
    setState(() => this.department = department);
  }

  void onContactChanged(String contact) {
    setState(() => this.contact = contact);
  }

  void onEmailChanged(String email) {
    setState(() => this.email = email);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Staff Member'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            initialValue: name,
            onChanged: onNameChanged,
            decoration: const InputDecoration(labelText: 'Full Name'),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: role,
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
                setState(() => role = value);
              }
            },
            decoration: const InputDecoration(labelText: 'Role'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: department,
            onChanged: onDepartmentChanged,
            decoration: const InputDecoration(labelText: 'Department'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: contact,
            decoration: const InputDecoration(labelText: 'Contact Number'),
            keyboardType: TextInputType.phone,
            onChanged: onContactChanged,
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: email,
            onChanged: onEmailChanged,
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
          onPressed: () async {
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

              await widget.onAddStaff(staff);
              if (mounted) {
                navigator.back();
              }
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
