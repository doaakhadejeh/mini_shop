import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final double latitude;
  final double longitude;
  final String? address;

  const LocationModel({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  @override
  List<Object?> get props => [latitude, longitude, address];
}
