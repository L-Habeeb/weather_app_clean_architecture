import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app_clean_architecture/core/usecases/usecase.dart';

import '../../../core/failures/failures.dart';
import '../entity/weatherdata.dart';
import '../repository/weather_data_repository.dart';

class GetWeatherByCity implements  UseCase<WeatherData, CityParams> {
  final WeatherDataRepository repository;

  GetWeatherByCity(this.repository);

  @override
  Future<Either<Failure, WeatherData>> call(CityParams params) {
    return repository.getWeatherByCity(params.typedCity);
  }
}


class CityParams extends Equatable {
  final String typedCity;

  const CityParams(this.typedCity);

  @override
  List<Object?> get props => [typedCity];
}
