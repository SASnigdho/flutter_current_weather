import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/errors/failures.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/repositories/i_weather_repository.dart';
import '../datasources/weather_remote_data_source.dart';

class WeatherRepository implements IWeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
    double lat,
    double lon,
  ) async {
    try {
      final weatherModel = await remoteDataSource.getCurrentWeather(lat, lon);
      return Right(weatherModel.toEntity());
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return Left(
          ServerFailure(
            'Connection timeout. Please check your internet connection.',
          ),
        );
      } else if (e.type == DioExceptionType.connectionError) {
        return Left(
          ServerFailure('No internet connection. Please check your network.'),
        );
      } else if (e.response?.statusCode == 401) {
        return Left(
          ServerFailure('Invalid API key. Please check your configuration.'),
        );
      } else if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Weather data not found for this location.'));
      } else if (e.response?.statusCode == 429) {
        return Left(
          ServerFailure('Too many requests. Please try again later.'),
        );
      } else {
        return Left(ServerFailure('Network error: ${e.message}'));
      }
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, WeatherEntity>> getWeatherByCity(String cityName) {
    return Future.value(Left(ServerFailure('City search not implemented yet')));
  }
}
