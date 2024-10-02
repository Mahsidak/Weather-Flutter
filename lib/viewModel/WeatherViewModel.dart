import 'package:flutter/material.dart';
import 'package:flutter_project/service/APIService.dart';
import '../model/ForecastModel.dart';
import '../model/CurrentWeather.dart';

class WeatherViewModel extends ChangeNotifier {
  int _temperature = 35;
  String _locationAbbreviation = 'JKT';
  String _locationFullName = 'Jakarta';
  List<HourlyForecastModel> _forecastData = [];

  CurrentWeatherResponse? _weatherData;
  CurrentWeatherResponse? get weatherData => _weatherData;

  int get temperature => _temperature;
  String get locationAbbreviation => _locationAbbreviation;
  String get locationFullName => _locationFullName;
  List<HourlyForecastModel> get forecastData => _forecastData;

  WeatherViewModel() {
    _forecastData = [
      HourlyForecastModel(hour: '9 AM', icon: Icons.wb_sunny, rainChance: 6),
      HourlyForecastModel(hour: '10 AM', icon: Icons.wb_sunny, rainChance: 7),
      HourlyForecastModel(hour: '11 AM', icon: Icons.wb_cloudy, rainChance: 8),
      HourlyForecastModel(hour: '12 PM', icon: Icons.wb_sunny, rainChance: 12),
      HourlyForecastModel(hour: '1 PM', icon: Icons.wb_cloudy, rainChance: 20),
      HourlyForecastModel(hour: '2 PM', icon: Icons.wb_cloudy, rainChance: 20),
      HourlyForecastModel(hour: '3 PM', icon: Icons.wb_cloudy, rainChance: 20),
    ];
    notifyListeners();
  }

  Future<void> fetchWeatherData(double lat, double lon) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&&units=metric&appid=cf8dd861e656ffeb86336eafb0cafe96';

    try {
      final response = await ApiService().get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        _weatherData = CurrentWeatherResponse.fromJson(data);
        print(data);
        print(weatherData?.weather[0].description);
        notifyListeners();
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (error) {
      print('Error fetching weather data: $error');
    }
  }
}