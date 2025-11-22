import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/weather_entity.dart';
import '../repositories/i_weather_repository.dart';

class GetCurrentWeather {
  final IWeatherRepository repository;

  GetCurrentWeather(this.repository);

  Future<Either<Failure, WeatherEntity>> call(double lat, double lon) async {
    return await repository.getCurrentWeather(lat, lon);
  }
}
