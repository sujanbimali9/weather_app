part of 'weatherbloc.dart';

class WeatherBlocState {}

class InitStates extends WeatherBlocState {}

class Loading extends WeatherBlocState {}

class Success extends WeatherBlocState {
  final List<WeatherData> weather;
  Success({required this.weather});
}

class Failure extends WeatherBlocState {
  final String error;
  Failure({required this.error});
}
