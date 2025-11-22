import 'package:geolocator/geolocator.dart';
import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

class LocationService {
  static Future<Either<Failure, Position>> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Left(LocationFailure('Location services are disabled. Please enable them.'));
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Left(LocationFailure('Location permissions are denied. Please grant location access.'));
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Left(LocationFailure(
            'Location permissions are permanently denied. Please enable them in app settings.'));
      }

      // Get the current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );
      
      return Right(position);
    } catch (e) {
      return Left(LocationFailure('Failed to get location: $e'));
    }
  }
}