import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app_clean_architecture/core/failures/failures.dart';
import 'package:weather_app_clean_architecture/core/usecases/usecase.dart';

import '../entity/weatherdata.dart';
import '../repository/weather_data_repository.dart';

class GetWeatherByLocation implements UseCase<WeatherData, LocationParams> {
  final WeatherDataRepository repository;

  const GetWeatherByLocation(this.repository);

  @override
  Future<Either<Failure, WeatherData>> call(LocationParams params) {
    return repository.getWeatherByLocation(
      latitude: params.latitude,
      longitude: params.longitude,
    );
  }

}


class LocationParams extends Equatable {
  final double longitude;
  final double latitude;

  const LocationParams(this.longitude, this.latitude);

  @override
  List<Object?> get props => [longitude, latitude];
}
