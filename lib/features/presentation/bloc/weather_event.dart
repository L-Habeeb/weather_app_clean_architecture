import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
  @override
  List<Object?> get props => [];
}

class GetWeatherByCityEvent extends WeatherEvent {
  final String cityName;
  const GetWeatherByCityEvent(this.cityName);
  @override
  List<Object?> get props => [cityName];
}

class GetWeatherByLocationEvent extends WeatherEvent {
  final double lat;
  final double lon;
  const GetWeatherByLocationEvent(this.lat, this.lon);
  @override
  List<Object?> get props => [lat, lon];
}
