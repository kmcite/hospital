import 'package:flutter/material.dart';
import 'package:hospital/domain/api/settings_repository.dart';
import 'package:hospital/main.dart';
import 'package:hospital/ui/core/funds_badge.dart';

mixin HospitalBannerX {
  void toggle() {
    settingsRepository(
      settingsRepository()..dark = !dark,
    );
  }

  bool get dark => settingsRepository().dark;
}

class HospitalBanner extends UI
    with HospitalBannerX
    implements PreferredSizeWidget {
  HospitalBanner();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('ER'),
      actions: [
        FundsBadge(),
        VerticalDivider(),
        CharityBadge(),
        IconButton(
          icon: Icon(
            dark ? Icons.light_mode : Icons.dark_mode,
          ),
          onPressed: () => toggle(),
        ).pad()
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
