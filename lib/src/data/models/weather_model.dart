import '../../domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.cityName,
    required super.temperature,
    required super.tempMin,
    required super.tempMax,
    required super.condition,
    required super.iconCode,
    required super.humidity,
    required super.windSpeed,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    try {
      return WeatherModel(
        cityName: json['name']?.toString() ?? 'Unknown Location',
        temperature: _parseDouble(json['main']['temp']),
        tempMin: _parseDouble(json['main']['temp_min']),
        tempMax: _parseDouble(json['main']['temp_max']),
        condition: json['weather'][0]['main']?.toString() ?? 'Unknown',
        iconCode: json['weather'][0]['icon']?.toString() ?? '01d',
        humidity: _parseInt(json['main']['humidity']),
        windSpeed: _parseDouble(json['wind']['speed']),
      );
    } catch (e) {
      throw FormatException('Failed to parse weather data: $e');
    }
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.round();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  WeatherEntity toEntity() {
    return WeatherEntity(
      cityName: cityName,
      temperature: temperature,
      tempMin: tempMin,
      tempMax: tempMax,
      condition: condition,
      iconCode: iconCode,
      humidity: humidity,
      windSpeed: windSpeed,
    );
  }
}
