import 'package:flutter/material.dart';
import './weather.dart';

void main() {
  runApp(const Weather());
}

class Weather extends StatelessWidget {
  const Weather({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: WeatherUI());
  }
}
