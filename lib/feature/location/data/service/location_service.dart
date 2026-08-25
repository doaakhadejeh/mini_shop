import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception('Location permission denied');
    }

    return Geolocator.getCurrentPosition();
  }

  Future<String> getLocationName({
    required double latitude,
    required double longitude,
  }) async {
    final placemarks = await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isEmpty) {
      throw Exception('Location name not found');
    }

    final place = placemarks.first;

    return '${place.locality}, ${place.country} , ${place.thoroughfare}';
  }
}
