import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weatherbloc.dart';
import 'package:weather_app/location_screen.dart';
import 'home_screen.dart';

void main() {
  runApp(const Weather());
}

class Weather extends StatelessWidget {
  const Weather({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        routes: {
          '/home': (context) => const WeatherUI(),
          '/location': (context) => const LocationScreen(),
        },
        home: const WeatherUI(),
      ),
    );
  }
}
