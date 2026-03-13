import 'package:dartz/dartz.dart';
import 'package:location/location.dart';

import '../../../core/failures/failures.dart';
import '../repository/weather_data_repository.dart';

class GetCurrentLocation {
  final WeatherDataRepository repository;

  GetCurrentLocation(this.repository);

  Future<Either<Failure, LocationData>> call() {
    return repository.getCurrentLocation();
  }

}