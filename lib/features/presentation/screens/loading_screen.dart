import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../data/datasources/weather_local_data_source.dart';
import '../../data/datasources/weather_local_data_source.dart';
import '../../injection_container.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    context.read<WeatherBloc>().add(GetCurrentLocationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is WeatherLocation) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    LocationScreen(locationData: state.locationData),
              ),
            );
          } else {
            Center(child: Text('Error from getting Location'));
          }
        },
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
