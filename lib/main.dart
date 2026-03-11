import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/injection_container.dart' as di;
import 'features/presentation/bloc/weather_bloc.dart';
import 'features/presentation/screens/loading_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<WeatherBloc>(),
      child: MaterialApp(theme: ThemeData.dark(), home: LoadingScreen()),
    );
  }
}
