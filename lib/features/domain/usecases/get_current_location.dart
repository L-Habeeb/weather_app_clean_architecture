import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/failures/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entity/location_data.dart';
import '../repository/weather_data_repository.dart';

class GetCurrentLocation implements UseCase<LocationEntity, NoParams> {
  final WeatherDataRepository repository;

  GetCurrentLocation(this.repository);
  @override
  Future<Either<Failure, LocationEntity>> call(NoParams params) {
    return repository.getCurrentLocation();
  }
}


class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}