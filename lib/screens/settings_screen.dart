import 'package:flutter/material.dart';
import 'package:hospital/business/hospital.dart';
import 'package:hospital/utils/sm.dart';

final class SettingsScreen extends UI {
  final HospitalProvider hospital;
  const SettingsScreen({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _SettingsAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const _SettingSwitch(title: 'Sound', value: true),
            const _SettingSwitch(title: 'Music', value: true),
            const _SettingSwitch(title: 'Vibration', value: false),
            const _SettingSwitch(title: 'Auto-save', value: true),

            SwitchListTile(
              value: hospital.hospital().dark,
              onChanged: (value) => hospital.toggleDark(),
              title: const Text('Dark Mode'),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: null,
                icon: const Icon(Icons.restart_alt),
                label: const Text('Reset Game'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _SettingsAppBar extends UI implements PreferredSizeWidget {
  const _SettingsAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back),
      ),
      title: const Text('Settings'),
    );
  }
}

final class _SettingSwitch extends StatefulWidget {
  final String title;
  final bool value;

  const _SettingSwitch({
    required this.title,
    required this.value,
  });

  @override
  State<_SettingSwitch> createState() => _SettingSwitchState();
}

final class _SettingSwitchState extends State<_SettingSwitch> {
  late bool value = widget.value;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      title: Text(widget.title),
      contentPadding: EdgeInsets.zero,
      onChanged: (newValue) {
        setState(() => value = newValue);
      },
    );
  }
}
