import 'package:intl/intl.dart';

class WeatherData {
  final String location;
  final String countryCode;
  final String temperature;
  final String weather;
  final String humidity;
  final String windSpeed;
  final String time;
  final String pressure;

  factory WeatherData.fromJson(Map<String, dynamic> map, int index) {
    return WeatherData(
      time: DateFormat.Hm()
          .format(DateTime.parse(map['list'][index]['dt_txt'].toString())),
      location: map['city']['name'].toString(),
      countryCode: map['city']['couuntry'].toString(),
      weather: map['list'][index]['weather'][0]['main'].toString(),
      temperature: map['list'][index]['main']['temp'].toString(),
      humidity: map['list'][index]['main']['humidity'].toString(),
      windSpeed: map['list'][index]['wind']['speed'].toString(),
      pressure: map['list'][index]['main']['pressure'].toString(),
    );
  }

  WeatherData(
      {required this.time,
      required this.location,
      required this.countryCode,
      required this.temperature,
      required this.weather,
      required this.humidity,
      required this.windSpeed,
      required this.pressure});
}
