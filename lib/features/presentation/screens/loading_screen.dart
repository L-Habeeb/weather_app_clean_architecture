import 'package:flutter/material.dart';

// import '../../data/datasources/weather_local_data_source.dart';
import '../../data/datasources/weather_local_data_source.dart';
import '../../injection_container.dart';
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
    final locationData = await sl<WeatherLocalDataSource>()
        .getCurrentLocation();

    if (!mounted) return;
    print("LOCATION RECEIVED: $locationData");

    // if (!mounted) return;

    print("NAVIGATINGsswsd");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(locationData: locationData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
