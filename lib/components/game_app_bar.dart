import 'package:flutter/material.dart';
import 'package:hospital/pages/game_page.dart';

class GameAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TabBar(
            tabs: PatientTab.values
                .map(
                  (p) => Tab(
                    text: p.name.toUpperCase(),
                  ),
                )
                .toList(),
          ),
          Text('HKNKSNKS'),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
