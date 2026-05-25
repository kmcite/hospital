import 'package:flutter/material.dart';

Widget backgroundImage() => Builder(
  builder: (context) => Align(
    alignment: Alignment.center,
    child: Icon(
      Icons.local_hospital_rounded,
      size: 300,
      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
    ),
  ),
);
