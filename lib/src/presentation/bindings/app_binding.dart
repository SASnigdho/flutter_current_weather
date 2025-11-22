import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../core/network/dio_client.dart';
import '../../data/datasources/weather_remote_data_source.dart';
import '../../data/repositories/weather_repository.dart';
import '../../domain/usecases/get_current_weather.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    // Core Dependencies
    Get.lazyPut<Dio>(() => DioClient.createDio(), fenix: true);

    // Data Layer
    Get.lazyPut<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(dio: Get.find<Dio>()),
      fenix: true,
    );

    // Domain Layer
    Get.lazyPut<WeatherRepository>(
      () => WeatherRepository(
        remoteDataSource: Get.find<WeatherRemoteDataSource>(),
      ),
      fenix: true,
    );

    // 
    Get.lazyPut<GetCurrentWeather>(
      () => GetCurrentWeather(Get.find<WeatherRepository>()),
      fenix: true,
    );
  }
}
