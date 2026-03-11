import 'package:equatable/equatable.dart';

class WeatherData extends Equatable {
  final String? message;
  final String cityName;
  final String? weatherIcon;
  final String country;
  final int temperature;
  final int condition;

  const WeatherData({
    this.message,
    this.weatherIcon,
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.condition,
  });

  @override
  List<Object?> get props => [
    message,
    cityName,
    country,
    temperature,
    condition,
  ];
}
