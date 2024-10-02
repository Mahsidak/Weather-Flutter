import 'package:flutter/material.dart';
import 'package:flutter_project/model/ForecastModel.dart';
import 'HourlyForecastColumnWidget.dart';

class HourlyForecastRowWidget extends StatelessWidget {
  final List<HourlyForecastModel> forecastData;

  HourlyForecastRowWidget({required this.forecastData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: forecastData.map((data) {
              return SizedBox(
                width: 65,
                child: HourlyForecastColumnWidget(
                  hour: data.hour,
                  icon: data.icon,
                  rainChance: data.rainChance,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
