class HourlyModel {
  final int dt;
  final MainData main;
  final List<Weather> weather;
  final Clouds clouds;
  final Wind wind;
  final int visibility;
  final double pop;
  final Rain? rain;  // Nullable
  final Sys sys;
  final String dtTxt;

  HourlyModel({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    this.rain,  // Nullable
    required this.sys,
    required this.dtTxt,
  });

  factory HourlyModel.fromJson(Map<String, dynamic> json) {
    return HourlyModel(
      dt: json['dt'] ?? 0,
      main: MainData.fromJson(json['main']),
      weather: List<Weather>.from(json['weather'].map((w) => Weather.fromJson(w))),
      clouds: Clouds.fromJson(json['clouds']),
      wind: Wind.fromJson(json['wind']),
      visibility: json['visibility'] ?? 0,
      pop: (json['pop'] != null) ? json['pop'].toDouble() : 0.0,  // Fallback if pop is null
      rain: json['rain'] != null ? Rain.fromJson(json['rain']) : null,  // Handle missing rain data
      sys: Sys.fromJson(json['sys']),
      dtTxt: json['dt_txt'] ?? '',
    );
  }
}

class MainData {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;

  MainData({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  factory MainData.fromJson(Map<String, dynamic> json) {
    return MainData(
      temp: json['temp']?.toDouble() ?? 0.0,
      feelsLike: json['feels_like']?.toDouble() ?? 0.0,
      tempMin: json['temp_min']?.toDouble() ?? 0.0,
      tempMax: json['temp_max']?.toDouble() ?? 0.0,
      pressure: json['pressure'] ?? 0,
      humidity: json['humidity'] ?? 0,
    );
  }
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'] ?? 0,
      main: json['main'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? '',
    );
  }
}

class Clouds {
  final int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'] ?? 0,
    );
  }
}

class Wind {
  final double speed;
  final int deg;
  final double gust;

  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed']?.toDouble() ?? 0.0,
      deg: json['deg'] ?? 0,
      gust: json['gust']?.toDouble() ?? 0.0,
    );
  }
}

class Rain {
  final double h3;

  Rain({required this.h3});

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(
      h3: json['3h']?.toDouble() ?? 0.0,  // Provide a default if '3h' is missing
    );
  }
}

class Sys {
  final String pod;

  Sys({required this.pod});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      pod: json['pod'] ?? '',
    );
  }
}

class City {
  final String name;
  final String country;
  final int population;

  City({
    required this.name,
    required this.country,
    required this.population,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      population: json['population'] ?? 0,
    );
  }
}