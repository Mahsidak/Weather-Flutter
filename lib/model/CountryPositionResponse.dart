class CountryPositionResponse {
  bool error;
  String msg;
  List<CountryPosition> data;

  CountryPositionResponse({
    required this.error,
    required this.msg,
    required this.data,
  });

  factory CountryPositionResponse.fromJson(Map<String, dynamic> json) {
    return CountryPositionResponse(
      error: json['error'] as bool,
      msg: json['msg'] as String,
      data: (json['data'] as List<dynamic>)
          .map((country) => CountryPosition.fromJson(country))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'msg': msg,
      'data': data.map((country) => country.toJson()).toList(),
    };
  }
}

class CountryPosition {
  String name;
  String iso2;
  double long;
  double lat;

  CountryPosition({
    required this.name,
    required this.iso2,
    required this.long,
    required this.lat,
  });

  factory CountryPosition.fromJson(Map<String, dynamic> json) {
    return CountryPosition(
      name: json['name'] as String,
      iso2: json['iso2'] as String,
      long: json['long'] is String
          ? double.tryParse(json['long']) ?? 0.0
          : (json['long'] as num).toDouble(),
      lat: json['lat'] is String
          ? double.tryParse(json['lat']) ?? 0.0
          : (json['lat'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'iso2': iso2,
      'long': long,
      'lat': lat,
    };
  }
}