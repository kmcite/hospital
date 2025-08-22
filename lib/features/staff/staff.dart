import 'package:forui/forui.dart';
import 'package:hospital/main.dart';
import 'package:hospital/utils/navigator.dart';

import '../../models/staff/staff.dart';

class StaffPage extends UI {
  final Staff staff;
  StaffPage({
    super.key,
    super.debugLabel,
    super.dependencies,
    required this.staff,
  });

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: staff.name.text(),
        prefixes: [
          FHeaderAction.back(onPress: navigator.back),
        ],
      ),
      child: SingleChildScrollView(
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
                  staff.name.text(),
                  staff.role.text(style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            Divider(height: 32),

            // Contact Information
            "Contact Information".text(),
            SizedBox(height: 8),
            FTile(
              prefix: Icon(Icons.email),
              title: "Email".text(),
              subtitle: staff.email.text(),
            ),
            FTile(
              prefix: Icon(Icons.phone),
              title: "Phone".text(),
              subtitle: staff.phone.text(),
            ),

            Divider(height: 32),

            // Professional Details
            "Professional Details".text(),
            SizedBox(height: 8),
            FTile(
              prefix: Icon(Icons.badge),
              title: "ID".text(),
              subtitle: staff.id.text(),
            ),
            FTile(
              prefix: Icon(Icons.work),
              title: "Department".text(),
              subtitle: staff.department.text(),
            ),
            FTile(
              prefix: Icon(Icons.calendar_today),
              title: "Join Date".text(),
              subtitle: staff.joinDate.toString().text(),
            ),

            if (staff.specialization != null) ...[
              Divider(height: 32),
              "Specialization".text(),
              SizedBox(height: 8),
              staff.specialization!.text(),
            ],

            if (staff.qualifications.isNotEmpty) ...[
              Divider(height: 32),
              "Qualifications".text(),
              SizedBox(height: 8),
              ...staff.qualifications.map(
                (qual) => ListTile(
                  leading: Icon(Icons.school),
                  title: qual.text(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
