import 'package:dio/dio.dart';

import '../../core/constants/constants.dart';
import '../../core/errors/exceptions.dart';
import '../../core/network/end_points.dart';
import '../models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(double lat, double lon);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSourceImpl({required this.dio});

  @override
  Future<WeatherModel> getCurrentWeather(double lat, double lon) async {
    try {
      final response = await dio.get(
        '${EndPoints.baseUrl}/weather',
        queryParameters: {'lat': lat, 'lon': lon, 'appid': Constants.apiKey},
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw ServerException(
          'Failed to load weather data: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerException('Server error: ${e.response?.statusCode}');
      } else {
        throw ServerException('Network error: ${e.message}');
      }
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }
}
