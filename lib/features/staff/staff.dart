import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital/repositories/staff_repository.dart';
import 'package:hospital/models/objectbox_models.dart';

class StaffCubit extends Cubit<StaffState> {
  late final StaffRepository _staffRepository;

  StaffCubit() : super(StaffLoading());

  // Future<StaffState> loadStaff() async {
  //   try {
  //     // await _staffRepository.refresh();
  //     // return StaffLoaded(staff: _staffRepository.state);
  //   } catch (e) {
  //     // return StaffError(message: 'Failed to load staff: $e');
  //   }
  // }

  // Future<void> addStaff(StaffMember staff) async {
  //   try {
  //     await _staffRepository.put(staff);
  //     await loadStaff();
  //   } catch (e) {
  //     emit(StaffError(message: 'Failed to add staff: $e'));
  //     rethrow;
  //   }
  // }
}

// States
abstract class StaffState {}

class StaffInitial extends StaffState {}

class StaffLoading extends StaffState {}

class StaffLoaded extends StaffState {
  final List<StaffMember> staff;

  StaffLoaded({required this.staff});
}

class StaffError extends StaffState {
  final String message;

  StaffError({required this.message});
}

class StaffView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital Staff'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // cubit.loadStaff();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _StaffBody(cubit: context.read()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _showAddStaffDialog(context, cubit.addStaff);
        },
        child: const Icon(Icons.person_add),
      ),
    );
  }
}

class _StaffBody extends StatelessWidget {
  final StaffCubit cubit;

  const _StaffBody({required this.cubit});

  @override
  Widget build(BuildContext context) {
    final state = cubit.state;
    if (state is StaffLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is StaffError) {
      return Center(child: Text('Error: ${state.message}'));
    } else if (state is StaffLoaded) {
      return _StaffListView(staff: state.staff);
    }
    return const Center(child: Text('No staff found'));
  }
}

class _StaffListView extends StatelessWidget {
  final List<StaffMember> staff;

  const _StaffListView({required this.staff});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: staff.length,
      itemBuilder: (context, index) {
        final member = staff[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(member.name),
            subtitle: Text('${member.role} | ${member.department}'),
            trailing: Text(member.isActive ? 'Active' : 'Inactive'),
            onTap: () {
              // Navigate to staff details
            },
          ),
        );
      },
    );
  }
}

// ignore: unused_element
void _showAddStaffDialog(
    BuildContext context, Future<void> Function(StaffMember) onAddStaff) async {
  final nameController = TextEditingController();
  final departmentController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  String selectedRole = 'doctor';

  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Add New Staff Member'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Full Name'),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: selectedRole,
            items: ['doctor', 'nurse', 'receptionist', 'administrator', 'other']
                .map((role) => DropdownMenuItem(
                      value: role,
                      child: Text(role),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                selectedRole = value;
              }
            },
            decoration: const InputDecoration(labelText: 'Role'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: departmentController,
            decoration: const InputDecoration(labelText: 'Department'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: contactController,
            decoration: const InputDecoration(labelText: 'Contact Number'),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            final name = nameController.text.trim();
            final department = departmentController.text.trim();
            final contact = contactController.text.trim();
            final email = emailController.text.trim();

            if (name.isNotEmpty &&
                department.isNotEmpty &&
                contact.isNotEmpty &&
                email.isNotEmpty) {
              final staff = StaffMember(
                name: name,
                role: selectedRole,
                department: department,
                contactNumber: contact,
                email: email,
              );

              await onAddStaff(staff);
              if (context.mounted) {
                Navigator.pop(context);
              }
            }
          },
          child: const Text('Add'),
        ),
      ],
    ),
  );
}
