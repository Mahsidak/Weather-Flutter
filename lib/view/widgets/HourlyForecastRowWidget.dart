import 'package:flutter/material.dart';
import 'package:flutter_project/model/HourlyModel.dart';
import 'HourlyForecastColumnWidget.dart';
import 'package:intl/intl.dart';

class HourlyForecastRowWidget extends StatelessWidget {
  final List<HourlyModel> forecastData;

  HourlyForecastRowWidget({required this.forecastData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: forecastData.map((data) {
              DateTime dateTime = DateTime.parse(data.dtTxt);
              String date = DateFormat('d MMM').format(dateTime);
              String hour = DateFormat('hh a').format(dateTime);
              String description = data.weather.first.description;
              return SizedBox(
                width: 70,
                child: HourlyForecastColumnWidget(
                  date: date,
                  hour: hour,
                  description: description,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
