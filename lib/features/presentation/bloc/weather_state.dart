import 'package:equatable/equatable.dart';
import 'package:location/location.dart';

import '../../domain/entity/weatherdata.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherData weather;
  const WeatherLoaded(this.weather);
  @override
  List<Object?> get props => [weather];
}

class WeatherError extends WeatherState {
  final String message;
  const WeatherError(this.message);
  @override
  List<Object?> get props => [message];
}


class WeatherLocation extends WeatherState {
  final LocationData locationData;

  const WeatherLocation({required this.locationData});

  @override
  List<Object?> get props => [locationData];
}
