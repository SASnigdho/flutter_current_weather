import 'package:get/get.dart';

import '../../domain/usecases/get_current_weather.dart';
import '../controllers/weather_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeatherController>(
      () => WeatherController(getCurrentWeather: Get.find<GetCurrentWeather>()),
    );
  }
}
