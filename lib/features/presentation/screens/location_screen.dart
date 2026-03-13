import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_clean_architecture/features/domain/entity/location_data.dart';

import '../../../core/presentation/constants.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';
import 'cityscreen.dart';

class LocationScreen extends StatefulWidget {
  final LocationEntity locationData;

  const LocationScreen({super.key, required this.locationData});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(
      GetWeatherByLocationEvent(
        widget.locationData.latitude,
        widget.locationData.longitude,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is WeatherLoaded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () async {
                              context.read<WeatherBloc>().add(
                                GetWeatherByLocationEvent(
                                  widget.locationData.latitude,
                                  widget.locationData.longitude,
                                ),
                              );
                            },
                            child: Icon(Icons.near_me, size: 50.0),
                          ),
                          TextButton(
                            onPressed: () async {
                              var cityInputName = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CityScreen(),
                                ),
                              );
                              if (cityInputName != null && context.mounted) {
                                context.read<WeatherBloc>().add(
                                  GetWeatherByCityEvent(cityInputName),
                                );
                              }
                            },
                            child: Icon(Icons.location_city, size: 50.0),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            Text(
                              '${state.weather.temperature}°C',
                              style: kTempTextStyle,
                            ),
                            Text(
                              '${state.weather.weatherIcon}',
                              style: kConditionTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Text(
                          '${state.weather.message}',
                          textAlign: TextAlign.right,
                          style: kMessageTextStyle,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
