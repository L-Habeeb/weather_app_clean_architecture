import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:weather_app_clean_architecture/features/data/model/weather_data_model.dart';

import '../../../core/error/exceptions.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherDataModel> getWeatherByCity(String typedCity);

  Future<WeatherDataModel> getWeatherByLocation(double lat, double long);
}

const BASE_URL = 'https://api.openweathermap.org/data/2.5';
const API_KEY = '1bec1c1fc986c6192f8999902b72317c';

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  const WeatherRemoteDataSourceImpl(this.client);

  @override
  Future<WeatherDataModel> getWeatherByCity(String typedCity) async {
    try {
      final response = await client
          .get(Uri.parse('$BASE_URL/forecast?q=$typedCity&appid=$API_KEY&units=metric'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return WeatherDataModel.fromCityJson(json.decode(response.body));
      }
      throw ServerException();
    } on SocketException {
      throw ServerException();
    } on TimeoutException {
      throw ServerException();
    }
  }

  @override
  Future<WeatherDataModel> getWeatherByLocation(double lat, double long) async {
    try {
      final response = await client
          .get(Uri.parse('$BASE_URL/weather?lat=$lat&lon=$long&appid=$API_KEY&units=metric'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return WeatherDataModel.fromLocationJson(json.decode(response.body));
      }
      throw ServerException();
    } on SocketException {
      throw ServerException();
    } on TimeoutException {
      throw ServerException();
    }
  }
}





// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
// import 'package:weather_app_clean_architecture/features/data/model/weather_data_model.dart';
//
// import '../../../core/error/exceptions.dart';
//
// abstract class WeatherRemoteDataSource {
//   Future<WeatherDataModel> getWeatherByCity(String typedCity);
//
//   Future<WeatherDataModel> getWeatherByLocation(double lat, double long);
// }
//
// // https://api.openweathermap.org/data/2.5/forecast?q=Ibadan&appid=1bec1c1fc986c6192f8999902b72317c
// //
// // https://api.openweathermap.org/data/2.5/weather?lat=7.3&lon=3.8778&appid=1bec1c1fc986c6192f8999902b72317c
//
// const BASE_URL = 'https://api.openweathermap.org/data/2.5';
// const API_KEY = '1bec1c1fc986c6192f8999902b72317c';
//
// class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
//   final http.Client client;
//
//   const WeatherRemoteDataSourceImpl(this.client);
//
//   @override
//   Future<WeatherDataModel> getWeatherByCity(String typedCity) async {
//     final response = await client.get(
//       Uri.parse('$BASE_URL/forecast?q=$typedCity&appid=$API_KEY&units=metric'),
//       // Uri.parse('$BASE_URL/forecast?q=$typedCity&appid=$API_KEY'),
//     ).timeout(const Duration(seconds: 10));
//     if (response.statusCode == 200) {
//       return WeatherDataModel.fromCityJson(json.decode(response.body));
//     }
//     throw ServerException();
//   }
//
//   @override
//   Future<WeatherDataModel> getWeatherByLocation(double lat, double long) async {
//     final response = await client.get(
//       Uri.parse(
//         '$BASE_URL/weather?lat=$lat&lon=$long&appid=$API_KEY&units=metric',
//       ),
//       // Uri.parse(
//       //   '$BASE_URL/weather?lat=7.3&lon=3.8778&appid=1bec1c1fc986c6192f8999902b72317c',
//       // ),
//     ).timeout(const Duration(seconds: 10));
//     if (response.statusCode == 200) {
//       return WeatherDataModel.fromLocationJson(json.decode(response.body));
//     }
//     throw ServerException();
//   }
//
// }
