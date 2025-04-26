import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/main.dart';
import 'package:manager/dark/dark_repository.dart';

bool get _dark => darkRepository.dark;
void _toggle() => darkRepository.toggle();

@deprecated
class HospitalBanner extends UI implements PreferredSizeWidget {
  HospitalBanner();

  @override
  Widget build(context) {
    return FHeader(
      title: const Text('Hospital'),
      actions: [
        FButton.icon(
          child: FIcon(
            _dark ? FAssets.icons.moon : FAssets.icons.sun,
          ),
          onPress: _toggle,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
