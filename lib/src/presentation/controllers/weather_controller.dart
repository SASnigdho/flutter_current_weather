import 'package:get/get.dart';

import '../../core/errors/failures.dart';
import '../../core/utils/location_service.dart';
import '../../domain/usecases/get_current_weather.dart';

class WeatherController extends GetxController {
  final GetCurrentWeather getCurrentWeather;

  WeatherController({required this.getCurrentWeather});

  // States
  final isLoading = false.obs;
  final weather = Rxn<dynamic>();
  final errorMessage = ''.obs;
  final lastUpdate = Rxn<DateTime>();

  @override
  void onInit() {
    super.onInit();
    fetchCurrentWeather();
  }

  Future<void> fetchCurrentWeather() async {
    try {
      isLoading(true);
      errorMessage('');

      final locationResult = await LocationService.getCurrentLocation();

      locationResult.fold(
        (locationFailure) {
          errorMessage(_mapFailureToMessage(locationFailure));
          weather.value = null;
        },
        (position) async {
          final weatherResult = await getCurrentWeather.call(
            position.latitude,
            position.longitude,
          );

          weatherResult.fold(
            (weatherFailure) {
              errorMessage(_mapFailureToMessage(weatherFailure));
              weather.value = null;
            },
            (weatherData) {
              weather.value = weatherData;
              lastUpdate.value = DateTime.now();
              errorMessage('');
            },
          );
        },
      );

      isLoading(false);
    } catch (e) {
      errorMessage('An unexpected error occurred: $e');
      weather.value = null;
    } finally {
      isLoading(false);
    }
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is LocationFailure) {
      return failure.message;
    } else if (failure is CacheFailure) {
      return failure.message;
    } else {
      return 'An unexpected error occurred';
    }
  }

  String get lastUpdateText {
    if (lastUpdate.value == null) return '';
    final now = DateTime.now();
    final difference = now.difference(lastUpdate.value!);

    if (difference.inMinutes < 1) {
      return 'Updated just now';
    } else if (difference.inMinutes < 60) {
      return 'Updated ${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return 'Updated ${difference.inHours} hours ago';
    } else {
      return 'Updated ${difference.inDays} days ago';
    }
  }
}
