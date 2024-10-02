import 'package:flutter/material.dart';

class HourlyForecastColumnWidget extends StatelessWidget {
  final String hour;
  final IconData icon;
  final int rainChance;

  HourlyForecastColumnWidget({
    required this.hour,
    required this.icon,
    required this.rainChance,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        SizedBox(height: 5),
        Text(hour),
        SizedBox(height: 5),
        Text('$rainChance%'),
      ],
    );
  }
}