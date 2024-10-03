import 'package:flutter/material.dart';

class HourlyForecastModel {
  final String hour;
  final IconData icon;
  final int rainChance;

  HourlyForecastModel({
    required this.hour,
    required this.icon,
    required this.rainChance,
  });
}