class WeatherEntity {
  final String cityName;
  final String countryCode;
  final double temperature; // in Celsius
  final double feelsLike; // in Celsius
  final double tempMin; // in Celsius
  final double tempMax; // in Celsius
  final String condition;
  final String description;
  final String iconCode;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final int visibility;
  final int cloudiness;
  final DateTime? sunrise;
  final DateTime? sunset;

  const WeatherEntity({
    required this.cityName,
    required this.countryCode,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.condition,
    required this.description,
    required this.iconCode,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.visibility,
    required this.cloudiness,
    required this.sunrise,
    required this.sunset,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherEntity &&
        other.cityName == cityName &&
        other.countryCode == countryCode &&
        other.temperature == temperature &&
        other.feelsLike == feelsLike &&
        other.tempMin == tempMin &&
        other.tempMax == tempMax &&
        other.condition == condition &&
        other.description == description &&
        other.iconCode == iconCode &&
        other.humidity == humidity &&
        other.windSpeed == windSpeed &&
        other.pressure == pressure &&
        other.visibility == visibility &&
        other.cloudiness == cloudiness &&
        other.sunrise == sunrise &&
        other.sunset == sunset;
  }

  @override
  int get hashCode {
    return cityName.hashCode ^
        countryCode.hashCode ^
        temperature.hashCode ^
        feelsLike.hashCode ^
        tempMin.hashCode ^
        tempMax.hashCode ^
        condition.hashCode ^
        description.hashCode ^
        iconCode.hashCode ^
        humidity.hashCode ^
        windSpeed.hashCode ^
        pressure.hashCode ^
        visibility.hashCode ^
        cloudiness.hashCode ^
        sunrise.hashCode ^
        sunset.hashCode;
  }
}