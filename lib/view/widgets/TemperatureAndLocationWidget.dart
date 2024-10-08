import 'package:flutter/material.dart';

class TemperatureAndLocationWidget extends StatelessWidget {
  final int temperature;
  final String locationAbbreviation;

  TemperatureAndLocationWidget({
    required this.temperature,
    required this.locationAbbreviation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          temperature == 0 ? '' : '$temperature°',
          style: const TextStyle(
            fontSize: 120,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          locationAbbreviation,
          style: const TextStyle(
            fontSize: 200,
            fontWeight: FontWeight.w100,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
