import '../../domain/entity/weatherdata.dart';
import '../../../core/presentation/message_helper.dart';

class WeatherDataModel extends WeatherData {
  const WeatherDataModel({
    required super.message,
    required super.cityName,
    required super.country,
    required super.temperature,
    required super.condition,
    required super.weatherIcon,
  });

  factory WeatherDataModel.fromCityJson(Map<String, dynamic> json) {
    final messageHelper = MessageHelper();

    final list = json['list'] as List;
    final temperature = (list[0]['main']['temp'] as num).toInt();
    final condition = list[0]['weather'][0]['id'] as int;
    final cityName = json['city']['name'];
    final country = json['city']['country'];

    return WeatherDataModel(
      weatherIcon: messageHelper.getWeatherIcon(condition),
      message: '${messageHelper.getMessage(temperature)} in $cityName, $country',
      cityName: cityName,
      country: country,
      temperature: temperature,
      condition: condition,
    );
  }

  factory WeatherDataModel.fromLocationJson(Map<String, dynamic> json) {
    final messageHelper = MessageHelper();

    final temperature = (json['main']['temp'] as num).toInt();
    final condition = json['weather'][0]['id'] as int;
    final cityName = json['name'];
    final country = json['sys']['country'];

    return WeatherDataModel(
      weatherIcon: messageHelper.getWeatherIcon(condition),
      message: '${messageHelper.getMessage(temperature)} in $cityName, $country',
      // message: messageHelper.getMessage(temperature),
      cityName: cityName,
      country: country,
      temperature: temperature,
      condition: condition,
    );
  }
}