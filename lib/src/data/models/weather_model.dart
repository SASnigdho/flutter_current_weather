import '../../domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.cityName,
    required super.countryCode,
    required super.temperature,
    required super.feelsLike,
    required super.tempMin,
    required super.tempMax,
    required super.condition,
    required super.description,
    required super.iconCode,
    required super.humidity,
    required super.windSpeed,
    required super.pressure,
    required super.visibility,
    required super.cloudiness,
    required super.sunrise,
    required super.sunset,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    try {
      // Convert Kelvin to Celsius
      final tempKelvin = _parseDouble(json['main']['temp']);
      final feelsLikeKelvin = _parseDouble(json['main']['feels_like']);
      final tempMinKelvin = _parseDouble(json['main']['temp_min']);
      final tempMaxKelvin = _parseDouble(json['main']['temp_max']);

      final temperatureCelsius = _kelvinToCelsius(tempKelvin);
      final feelsLikeCelsius = _kelvinToCelsius(feelsLikeKelvin);
      final tempMinCelsius = _kelvinToCelsius(tempMinKelvin);
      final tempMaxCelsius = _kelvinToCelsius(tempMaxKelvin);

      // Parse sunrise and sunset timestamps
      final sunriseTimestamp = json['sys']['sunrise'] as int?;
      final sunsetTimestamp = json['sys']['sunset'] as int?;

      return WeatherModel(
        cityName: json['name']?.toString() ?? 'Unknown Location',
        countryCode: json['sys']['country']?.toString() ?? '',
        temperature: temperatureCelsius,
        feelsLike: feelsLikeCelsius,
        tempMin: tempMinCelsius,
        tempMax: tempMaxCelsius,
        condition: json['weather'][0]['main']?.toString() ?? 'Unknown',
        description: json['weather'][0]['description']?.toString() ?? '',
        iconCode: json['weather'][0]['icon']?.toString() ?? '01d',
        humidity: _parseInt(json['main']['humidity']),
        windSpeed: _parseDouble(json['wind']['speed']),
        pressure: _parseInt(json['main']['pressure']),
        visibility: _parseInt(json['visibility']),
        cloudiness: _parseInt(json['clouds']['all']),
        sunrise: sunriseTimestamp != null ? DateTime.fromMillisecondsSinceEpoch(sunriseTimestamp * 1000) : null,
        sunset: sunsetTimestamp != null ? DateTime.fromMillisecondsSinceEpoch(sunsetTimestamp * 1000) : null,
      );
    } catch (e) {
      throw FormatException('Failed to parse weather data: $e');
    }
  }

  static double _kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
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
      countryCode: countryCode,
      temperature: temperature,
      feelsLike: feelsLike,
      tempMin: tempMin,
      tempMax: tempMax,
      condition: condition,
      description: description,
      iconCode: iconCode,
      humidity: humidity,
      windSpeed: windSpeed,
      pressure: pressure,
      visibility: visibility,
      cloudiness: cloudiness,
      sunrise: sunrise,
      sunset: sunset,
    );
  }
}