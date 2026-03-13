import 'package:dartz/dartz.dart';

import 'package:weather_app_clean_architecture/core/failures/failures.dart';

import 'package:weather_app_clean_architecture/features/domain/entity/weatherdata.dart';

import '../../../core/error/exceptions.dart';
import '../../domain/entity/location_data.dart';
import '../../domain/repository/weather_data_repository.dart';
import '../datasources/weather_data_data_source.dart';
import '../datasources/weather_local_data_source.dart';

class WeatherDataRepositoryImpl extends WeatherDataRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource locationDataSource;

  WeatherDataRepositoryImpl({
    required this.locationDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, WeatherData>> getWeatherByCity(
    String typedCity,
  ) async {
    try {
      final weatherResult = await remoteDataSource.getWeatherByCity(typedCity);
      return Right(weatherResult);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, WeatherData>> getWeatherByLocation({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final weatherResult = await remoteDataSource.getWeatherByLocation(
        latitude,
        longitude,
      );
      return Right(weatherResult);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, LocationEntity>> getCurrentLocation() async {
    try {
      final currentLocation = await locationDataSource.getCurrentLocation();
      return Right(currentLocation);
    } on LocationException {
      return Left(LocationFailure());
    }
  }
}
