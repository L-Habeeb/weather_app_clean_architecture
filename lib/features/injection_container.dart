import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:weather_app_clean_architecture/features/presentation/bloc/weather_bloc.dart';

import 'data/datasources/weather_data_data_source.dart';
import 'data/datasources/weather_local_data_source.dart';
import 'data/repository/weather_data_repository_impl.dart';
import 'domain/repository/weather_data_repository.dart';
import 'domain/usecases/get_current_location.dart';
import 'domain/usecases/get_weather_by_city.dart';
import 'domain/usecases/get_weather_by_location.dart';

final sl = GetIt.instance;

void init() {
  // BLOC
  sl.registerFactory(
    () => WeatherBloc(
      getWeatherByCity: sl(),
      getWeatherByLocation: sl(),
      getCurrentLocation: sl(),
    ),
  );

  // USECASE
  sl.registerLazySingleton(() => GetWeatherByCity(sl()));
  sl.registerLazySingleton(() => GetWeatherByLocation(sl()));
  sl.registerLazySingleton(() => GetCurrentLocation(sl()));

  // REPOSITORY
  sl.registerLazySingleton<WeatherDataRepository>(
    () => WeatherDataRepositoryImpl(
      remoteDataSource: sl(),
      locationDataSource: sl(),
    ),
  );

  // DATASOURCE
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<WeatherLocalDataSource>(
    () => WeatherLocalDataSourceImpl(sl()),
  );

  // External
  sl.registerLazySingleton(() => Location());
  sl.registerLazySingleton(() => http.Client());
}
