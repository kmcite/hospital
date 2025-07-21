import 'package:flutter/material.dart';
import 'package:hospital/main.dart';
import 'package:hospital/utils/list_view.dart';

class Staff {
  String id = faker.guid.guid();
  String name = faker.person.name();
  String role = faker.vehicle.model();
  String department = faker.company.name();
  double salary = faker.randomGenerator.decimal(scale: 500, min: 50);
}

final _staffs = mapSignal<String, Staff>({});

final staffs = computed(() => _staffs.values);

void fire_staff(Staff staff) {
  _staffs.remove(staff.id);
}

void hire_staff(Staff staff) {
  _staffs.putIfAbsent(staff.id, () => staff);
}

class StaffsUI extends UI {
  @override
  Widget build(BuildContext context) {
    return listView(
      staffs(),
      (staff) => FTile(
        title: staff.name.text(),
      ),
    );
  }
}
