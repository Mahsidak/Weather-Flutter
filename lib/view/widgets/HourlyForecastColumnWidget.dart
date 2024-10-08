import 'package:flutter/material.dart';

class HourlyForecastColumnWidget extends StatelessWidget {
  final String date;
  final String hour;
  final String description;

  HourlyForecastColumnWidget({
    required this.date,
    required this.hour,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(date),
        SizedBox(height: 5),
        Text(hour),
        SizedBox(height: 5),
        Text(
          description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}