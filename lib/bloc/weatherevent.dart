part of 'weatherbloc.dart';

class WeatherEvent {}

class Refresh extends WeatherEvent {
  final String location;
  final String apiKey;
  final String countryCode;

  Refresh(
      {required this.location,
      required this.apiKey,
      required this.countryCode});
}

class ChangeLocation extends WeatherEvent {
  final String location;
  final String apiKey;
  final String countryCode;

  ChangeLocation(
      {required this.location,
      required this.apiKey,
      required this.countryCode});
}

class GetWeaterData extends WeatherEvent {
  final String location;
  final String apiKey;
  final String countryCode;
  GetWeaterData(
      {required this.apiKey,
      required this.countryCode,
      required this.location});
}
