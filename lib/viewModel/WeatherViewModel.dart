import 'package:flutter/material.dart';
import 'package:flutter_project/service/APIService.dart';
import '../model/ForecastModel.dart';
import '../model/CurrentWeather.dart';
import '../model/CountryPositionResponse.dart';
import 'package:geolocator/geolocator.dart';

class WeatherViewModel extends ChangeNotifier {
  int _temperature = 0;
  String _locationAbbreviation = '';
  List<HourlyForecastModel> _forecastData = [];

  CurrentWeatherResponse? _weatherData;
  CurrentWeatherResponse? get weatherData => _weatherData;

  CountryPositionResponse? _countryPosition;
  CountryPositionResponse? get countryPosition => _countryPosition;

  int get temperature => _temperature;
  String get locationAbbreviation => _locationAbbreviation;
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
        _temperature = weatherData?.main.temp ?? 0;
        _locationAbbreviation = weatherData?.sys.country ?? "";
        print(weatherData?.main.temp ?? 0);
        notifyListeners();
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (error) {
      print('Error fetching weather data: $error');
    }
  }

  Future<void> getAllCountryList() async {
    final url = 'https://countriesnow.space/api/v0.1/countries/positions';

    try {
      final response = await ApiService().get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        _countryPosition = CountryPositionResponse.fromJson(data);
        print(data);
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

    double lat = position.latitude;
    double lon = position.longitude;

    print('Latitude: $lat, Longitude: $lon');

    await fetchWeatherData(lat, lon);
    await getAllCountryList();
  }

}