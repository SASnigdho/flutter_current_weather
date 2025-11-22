class WeatherEntity {
  final String cityName;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final String condition;
  final String iconCode;
  final int humidity;
  final double windSpeed;

  const WeatherEntity({
    required this.cityName,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.condition,
    required this.iconCode,
    required this.humidity,
    required this.windSpeed,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherEntity &&
        other.cityName == cityName &&
        other.temperature == temperature &&
        other.tempMin == tempMin &&
        other.tempMax == tempMax &&
        other.condition == condition &&
        other.iconCode == iconCode &&
        other.humidity == humidity &&
        other.windSpeed == windSpeed;
  }

  @override
  int get hashCode {
    return cityName.hashCode ^
        temperature.hashCode ^
        tempMin.hashCode ^
        tempMax.hashCode ^
        condition.hashCode ^
        iconCode.hashCode ^
        humidity.hashCode ^
        windSpeed.hashCode;
  }
}
