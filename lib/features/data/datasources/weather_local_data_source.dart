import 'package:location/location.dart';

import '../../../core/error/exceptions.dart';
import '../../domain/entity/location_data.dart';

abstract class WeatherLocalDataSource {
  Future<LocationEntity> getCurrentLocation();
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final Location location;

  WeatherLocalDataSourceImpl(this.location);

  @override
  Future<LocationEntity> getCurrentLocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) throw LocationException();
    }

    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) throw LocationException();
    }

    final locationData = await location.getLocation();

    return LocationEntity(
      longitude: locationData.longitude!,
      latitude: locationData.latitude!,
    );
  }
}
