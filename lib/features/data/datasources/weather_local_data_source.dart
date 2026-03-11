import 'package:location/location.dart';

import '../../../core/error/exceptions.dart';

abstract class WeatherLocalDataSource {
  Future<LocationData> getCurrentLocation();
}


class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final Location location;
  WeatherLocalDataSourceImpl(this.location);

  @override
  Future<LocationData> getCurrentLocation() async {
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

    return await location.getLocation();
  }
}