import 'package:flutter/material.dart';
import 'package:flutter_project/service/APIService.dart';
import '../model/ForecastModel.dart';
import '../model/CurrentWeather.dart';
import '../model/CountryPositionResponse.dart';
import 'package:geolocator/geolocator.dart';
import '../model/HourlyModel.dart';

class WeatherViewModel extends ChangeNotifier {
  int _temperature = 0;
  int get temperature => _temperature;

  String _locationAbbreviation = '';
  String get locationAbbreviation => _locationAbbreviation;

  List<HourlyModel> _forecastData = [];
  List<HourlyModel> get forecastData => _forecastData;

  CurrentWeatherResponse? _weatherData;
  CurrentWeatherResponse? get weatherData => _weatherData;

  CountryPositionResponse? _countryPosition;
  CountryPositionResponse? get countryPosition => _countryPosition;

  double _lat = 0.0;
  double _lon = 0.0;

  Future<void> fetchWeatherData(double lat, double lon) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?lat=$_lat&lon=$_lon&units=metric&appid=cf8dd861e656ffeb86336eafb0cafe96';

    try {
      final response = await ApiService().get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        _weatherData = CurrentWeatherResponse.fromJson(data);
        _temperature = weatherData?.main.temp ?? 0;
        _locationAbbreviation = weatherData?.sys.country ?? "";
        notifyListeners();
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (error) {
      print('Error fetching weather data: $error');
    }
  }

  Future<void> fetchHourlyForecast(double lat, double lon) async {
    final url = 'https://api.openweathermap.org/data/2.5/forecast?lat=$_lat&lon=$_lon&units=metric&appid=cf8dd861e656ffeb86336eafb0cafe96';

    try {
      final response = await ApiService().get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        print(data);
        _forecastData = (data['list'] as List)
            .map((item) => HourlyModel.fromJson(item))
            .toList();
        print(forecastData.length);
        notifyListeners();
      } else {
        throw Exception('Something went wrong while fetching country list.');
      }
    } catch (error) {
      print('Error fetching hourly forecast data: $error');
    }
  }

  Future<void> getAllCountryList() async {
    const url = 'https://countriesnow.space/api/v0.1/countries/positions';

    try {
      final response = await ApiService().get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        _countryPosition = CountryPositionResponse.fromJson(data);
        notifyListeners();
      } else {
        throw Exception('Something went wrong while fetching country list.');
      }
    } catch (error) {
      print('Error fetching country data: $error');
    }
  }

  Future<void> getUserLocationAndFetchWeather() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied, cannot request permissions.');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    _lat = position.latitude;
    _lon = position.longitude;

    await fetchWeatherData(_lat, _lon);
    print('Hello');
    await fetchHourlyForecast(_lat, _lon);
    await getAllCountryList();
  }

}