import 'package:flutter/material.dart';
import 'package:weather_app/location_screen.dart';
import './weather.dart';

void main() {
  runApp(const Weather());
}

class Weather extends StatelessWidget {
  const Weather({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routes: {
        '/home': (context) => const WeatherUI(),
        '/location': (context) => const LocationScreen(),
      },
      home: const WeatherUI(),
    );
  }
}
