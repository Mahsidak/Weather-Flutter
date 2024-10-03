class CurrentWeatherResponse {
  final Coord coord;
  final List<Weather> weather;
  final Main main;
  final Wind wind;
  final Clouds clouds;
  final Rain? rain;
  final Sys sys;
  final String name;
  final int timezone;
  final int dt;
  final int id;

  CurrentWeatherResponse({
    this.coord = const Coord(),
    this.weather = const [],
    this.main = const Main(),
    this.wind = const Wind(),
    this.clouds = const Clouds(),
    this.rain,
    this.sys = const Sys(),
    this.name = '',
    this.timezone = 0,
    this.dt = 0,
    this.id = 0,
  });

  factory CurrentWeatherResponse.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherResponse(
      coord: Coord.fromJson(json['coord']),
      weather: List<Weather>.from(json['weather'].map((x) => Weather.fromJson(x))),
      main: Main.fromJson(json['main']),
      wind: Wind.fromJson(json['wind']),
      clouds: Clouds.fromJson(json['clouds']),
      rain: json['rain'] != null ? Rain.fromJson(json['rain']) : null,
      sys: Sys.fromJson(json['sys']),
      name: json['name'],
      timezone: json['timezone'],
      dt: json['dt'],
      id: json['id'],
    );
  }
}

class Coord {
  final double lon;
  final double lat;

  const Coord({this.lon = 0.0, this.lat = 0.0});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: json['lon'].toDouble(),
      lat: json['lat'].toDouble(),
    );
  }
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  const Weather({this.id = 0, this.main = '', this.description = '', this.icon = ''});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class Main {
  final int temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int seaLevel;
  final int grndLevel;

  const Main({
    this.temp = 0,
    this.feelsLike = 0.0,
    this.tempMin = 0.0,
    this.tempMax = 0.0,
    this.pressure = 0,
    this.humidity = 0,
    this.seaLevel = 0,
    this.grndLevel = 0,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'].toInt(),
      feelsLike: json['feels_like'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
      seaLevel: json['sea_level'] ?? 0,
      grndLevel: json['grnd_level'] ?? 0,
    );
  }
}

class Wind {
  final double speed;
  final int deg;
  final double? gust;

  const Wind({this.speed = 0.0, this.deg = 0, this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'].toDouble(),
      deg: json['deg'],
      gust: json['gust'] != null ? json['gust'].toDouble() : null,
    );
  }
}

class Clouds {
  final int all;

  const Clouds({this.all = 0});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }
}

class Rain {
  final double oneHour;

  const Rain({this.oneHour = 0.0});

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(
      oneHour: json['1h'].toDouble(),
    );
  }
}

class Sys {
  final int type;
  final int id;
  final String country;
  final int sunrise;
  final int sunset;

  const Sys({
    this.type = 0,
    this.id = 0,
    this.country = '',
    this.sunrise = 0,
    this.sunset = 0,
  });

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      type: json['type'],
      id: json['id'],
      country: json['country'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}