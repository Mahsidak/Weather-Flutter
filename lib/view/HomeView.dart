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
    final weatherViewModel = Provider.of<WeatherViewModel>(context, listen: false);
    weatherViewModel.fetchWeatherData(37.7749, -122.4194);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherViewModel(),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/sunny-bg.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<WeatherViewModel>(
                builder: (context, viewModel, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Today"),
                      TemperatureAndLocationWidget(
                        temperature: viewModel.temperature,
                        locationAbbreviation: viewModel.locationAbbreviation,
                      ),
                      HourlyForecastRowWidget(
                        forecastData: viewModel.forecastData,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}