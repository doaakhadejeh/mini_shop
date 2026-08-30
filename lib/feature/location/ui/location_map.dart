import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:mimi_shope/feature/location/data/model/location_model.dart';

class LocationMap extends StatefulWidget {
  final LocationModel? location;
  const LocationMap({super.key, required this.location});

  @override
  State<LocationMap> createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  late LatLng selectedLocation;
  late double latitude;
  late double longitude;
  static const double defaultLat = 33.5138;
  static const double defaultLng = 36.2765;

  @override
  void initState() {
    super.initState();

    latitude = widget.location?.latitude ?? defaultLat;
    longitude = widget.location?.longitude ?? defaultLng;
    selectedLocation = LatLng(latitude, longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final location = LocationModel(
            latitude: selectedLocation.latitude,
            longitude: selectedLocation.longitude,
          );

          context.pop(location);
        },
        icon: const Icon(Icons.check),
        label: const Text('Confirm Location'),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(longitude, longitude),
          initialZoom: 15,
          onTap: (tapPosition, point) {
            setState(() {
              selectedLocation = point;
            });
          },
        ),

        children: [
          TileLayer(
            // urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            urlTemplate:
                'https://a.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}@2x.png',
            // urlTemplate:
            //     'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
            userAgentPackageName: 'com.example.mimi_shope',
          ),

          MarkerLayer(
            markers: [
              Marker(
                point: selectedLocation,
                width: 50,
                height: 50,
                child: const Icon(
                  Icons.location_pin,
                  size: 45,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution('OpenStreetMap contributors', onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
