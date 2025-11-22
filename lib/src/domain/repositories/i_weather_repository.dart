import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/weather_entity.dart';

abstract class IWeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
    double lat,
    double lon,
  );

  Future<Either<Failure, WeatherEntity>> getWeatherByCity(String cityName);
}
