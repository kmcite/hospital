import 'package:flutter/material.dart';
import 'package:hospital/ui/core/funds_badge.dart';

Widget FundsUI() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 12,
          children: [
            FundsBadge(),
            CharityBadge(),
          ],
        ),
      ),
    ],
  );
}
