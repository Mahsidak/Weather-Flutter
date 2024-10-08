import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/WeatherViewModel.dart';
import 'widgets/TemperatureAndLocationWidget.dart';
import 'widgets/HourlyForecastRowWidget.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => _fetchWeatherData());
  }

  void _fetchWeatherData() {
    final weatherViewModel =
        Provider.of<WeatherViewModel>(context, listen: false);
    weatherViewModel.getUserLocationAndFetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    final weatherViewModel = Provider.of<WeatherViewModel>(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/sunny-bg.png",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Today",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
                TemperatureAndLocationWidget(
                  temperature: weatherViewModel.temperature,
                  locationAbbreviation: weatherViewModel.locationAbbreviation,
                ),
                HourlyForecastRowWidget(
                  forecastData: weatherViewModel.forecastData,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
