import 'dart:developer';

import 'package:forui/forui.dart';
import 'package:hospital/domain/api/facilities.dart';
import 'package:hospital/domain/models/facility.dart';
import 'package:hospital/main.dart';
import 'package:hospital/navigator.dart';

mixin FacilitiesBloc {
  get facilities => facilities.hashCode;
  void put(Facility facility) {}
}

class FacilitiesPage extends UI with FacilitiesBloc {
  const FacilitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        prefixActions: [
          FHeaderAction.back(onPress: navigator.back),
        ],
        title: const Text('Facilities'),
      ),
      content: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: facilities.length,
              itemBuilder: (context, index) {
                final facility = facilities.elementAt(index);
                return FTile(
                  title: Text(facility.name),
                  subtitle: Text(
                    'Level: ${facility.currentLevel} | Beds: ${facility.totalBeds} | Upgrade Cost: \$${facility.upgradeCost}',
                  ),
                  suffixIcon: FButton.icon(
                    onPress:
                        context.of<Facilities>().upgradeFacility(facility.name)
                            ? () {
                                log('Upgraded ${facility.name}');
                              }
                            : null,
                    child: const Text('Upgrade'),
                  ),
                );
              },
            ),
          ),
          FButton.icon(
            style: FButtonStyle.primary,
            onPress: () async {
              final facilityName = TextEditingController();
              final facility = await navigator.toDialog<Facility>(
                FDialog(
                  title: 'Add Facility'.text(),
                  body: FTextField(
                    controller: facilityName,
                  ),
                  direction: Axis.horizontal,
                  actions: [
                    FButton(
                      onPress: () {
                        navigator.back(
                          Facility(
                            id: randomId,
                            name: facilityName.text,
                          ),
                        );
                        facilityName.clear();
                      },
                      label: 'save'.text(),
                    ),
                    FButton(
                      onPress: () {
                        navigator.back();
                        facilityName.clear();
                      },
                      label: 'cancel'.text(),
                    ),
                  ],
                ),
              );
              if (facility != null) put(facility);
            },
            child: FIcon(FAssets.icons.plus),
          ).pad(),
        ],
      ),
    );
  }
}
