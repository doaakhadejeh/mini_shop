import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import 'package:mimi_shope/core/error/api_error_model.dart';
import 'package:mimi_shope/core/error/api_error_state.dart';
import 'package:mimi_shope/feature/location/data/service/location_service.dart';

class LocationRepository {
  final LocationService _locationService;

  LocationRepository(this._locationService);

  Future<Either<Failure, Position>> getCurrentPosition() async {
    try {
      final position = await _locationService.getCurrentPosition();

      return Right(position);
    } catch (e) {
      return Left(handleException(e));
    }
  }

  Future<Either<Failure, String>> getLocationName({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final locationName = await _locationService.getLocationName(
        latitude: latitude,
        longitude: longitude,
      );

      return Right(locationName);
    } catch (e) {
      return Left(handleException(e));
    }
  }
}
