import 'dart:developer';

import 'package:hospital/hospital/facilities/facilities.dart';
import 'package:hospital/hospital/facilities/facility.dart';
import 'package:hospital/hospital/navigator/app_scaffold.dart';
import 'package:hospital/main.dart';

class FacilitiesPage extends UI {
  const FacilitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: const Text('Facilities')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: facilities.facilities.length,
              itemBuilder: (context, index) {
                final facility = facilities.facilities.values.elementAt(index);
                return Card(
                  child: ListTile(
                    title: Text(facility.name),
                    subtitle: Text(
                        'Level: ${facility.currentLevel} | Beds: ${facility.totalBeds} | Upgrade Cost: \$${facility.upgradeCost}'),
                    trailing: ElevatedButton(
                      onPressed: facilities.upgradeFacility(facility.name)
                          ? () => log('Upgraded ${facility.name}')
                          : null,
                      child: const Text('Upgrade'),
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              facilities.addFacility(
                Facility(name: 'name'),
              );
            },
            child: Icon(Icons.add),
          ).pad(),
        ],
      ),
    );
  }
}
