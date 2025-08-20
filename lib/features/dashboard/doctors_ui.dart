import 'package:flutter/material.dart';
import 'package:hospital/main.dart';

import '../../models/staff/staff.dart';
import 'dashboard.dart';

List<Widget> genericStaffsUI<T extends Staff>() {
  return List.generate(
    staffs().length,
    (i) {
      final staff = staffs().elementAt(i);
      return GUI(
        () => ListTile(
          leading: staff.isHired() ? Icon(Icons.check) : Icon(Icons.close),
          title: staff.name.text(),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              '${staff.runtimeType}'.text(),
              LinearProgressIndicator(
                value: staff.percentage(),
              ),
            ],
          ),
          onTap: staff.isHired() ? staff.fire : staff.hire,
        ),
      );
    },
  );
}
