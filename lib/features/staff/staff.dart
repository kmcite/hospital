// import 'package:forui/forui.dart'; // Removed - using Material Design
import 'package:hospital/main.dart';

import '../../models/staff/staff.dart';

class StaffBloc extends Bloc {
  StaffBloc(this.staff);
  Staff staff;
}

class StaffPage extends Feature<StaffBloc> {
  final Staff staff;
  const StaffPage({
    super.key,
    required this.staff,
  });

  @override
  StaffBloc create() => StaffBloc(staff);

  @override
  Widget build(BuildContext context, StaffBloc controller) {
    return Scaffold(
      appBar: AppBar(
        title: Text(staff.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: navigator.back,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image and Basic Info
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: staff.imageUrl != null
                        ? NetworkImage(staff.imageUrl!)
                        : null,
                    child: staff.imageUrl == null
                        ? Icon(Icons.person, size: 60)
                        : null,
                  ),
                  SizedBox(height: 16),
                  Text(
                    staff.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    staff.role,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            ),

            Divider(height: 32),

            // Contact Information
            Text(
              'Contact Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text(staff.email),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone'),
              subtitle: Text(staff.phone),
            ),

            Divider(height: 32),

            // Professional Details
            Text(
              'Professional Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.badge),
              title: Text('ID'),
              subtitle: Text(staff.id.toString()),
            ),
            ListTile(
              leading: Icon(Icons.work),
              title: Text('Department'),
              subtitle: Text(staff.department),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Join Date'),
              subtitle: Text(staff.joinDate.toString()),
            ),

            if (staff.specialization != null) ...[
              Divider(height: 32),
              Text(
                'Specialization',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(staff.specialization!),
            ],

            if (staff.qualifications.isNotEmpty) ...[
              Divider(height: 32),
              Text(
                'Qualifications',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ...staff.qualifications.map(
                (qual) => ListTile(
                  leading: Icon(Icons.school),
                  title: Text(qual),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
