import 'package:dartz/dartz.dart';
import 'package:location/location.dart';

import '../../../core/failures/failures.dart';
import '../entity/weatherdata.dart';

abstract class WeatherDataRepository {
  Future<Either<Failure, WeatherData>> getWeatherByCity(String typedCity);

  Future<Either<Failure, WeatherData>> getWeatherByLocation({
    required double latitude,
    required double longitude,
  });

  Future<Either<Failure, LocationData>> getCurrentLocation();

}
