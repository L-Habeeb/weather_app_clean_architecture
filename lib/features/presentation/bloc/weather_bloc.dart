import 'package:bloc/bloc.dart';
import 'package:weather_app_clean_architecture/features/presentation/bloc/weather_event.dart';
import 'package:weather_app_clean_architecture/features/presentation/bloc/weather_state.dart';

import '../../domain/usecases/get_current_location.dart';
import '../../domain/usecases/get_weather_by_city.dart';
import '../../domain/usecases/get_weather_by_location.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherByCity getWeatherByCity;
  final GetWeatherByLocation getWeatherByLocation;
  final GetCurrentLocation getCurrentLocation;

  WeatherBloc({
    required this.getCurrentLocation,
    required this.getWeatherByCity,
    required this.getWeatherByLocation,
  }) : super(WeatherInitial()) {
    on<GetWeatherByCityEvent>(_onGetWeatherByCity);
    on<GetWeatherByLocationEvent>(_onGetWeatherByLocation);
    on<GetCurrentLocationEvent>(_onGetCurrentLocation);
  }

  Future<void> _onGetCurrentLocation(
    GetCurrentLocationEvent event,
    Emitter<WeatherState> emit,
  ) async {
    final result = await getCurrentLocation(NoParams());
    result.fold(
      (failure) =>
          emit(const WeatherError('Failed to fetch weather. Check city name.')),
      (locationData) => emit(WeatherLocation(locationData: locationData)),
    );
  }

  Future<void> _onGetWeatherByCity(
    GetWeatherByCityEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    final result = await getWeatherByCity(CityParams(event.cityName));
    result.fold(
      (failure) =>
          emit(const WeatherError('Failed to fetch weather. Check city name.')),
      (weather) => emit(WeatherLoaded(weather)),
    );
  }

  Future<void> _onGetWeatherByLocation(
    GetWeatherByLocationEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    final result = await getWeatherByLocation(
      LocationParams(latitude: event.lat, longitude: event.lon),
    );
    result.fold(
      (failure) =>
          emit(const WeatherError('Failed to fetch weather by location.')),
      (weather) => emit(WeatherLoaded(weather)),
    );
  }
}
