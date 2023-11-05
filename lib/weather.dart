import 'dart:convert';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:weather_app/container.dart';
import 'package:http/http.dart' as http;
import 'addinfo.dart';
import '.key.dart';
import 'package:flutter/material.dart';

class WeatherUI extends StatefulWidget {
  const WeatherUI({super.key});
  @override
  State<WeatherUI> createState() => _WeatherUIaState();
}

class _WeatherUIaState extends State<WeatherUI> {
  dynamic data;
  String temp = '0';
  dynamic humidity = '0';
  dynamic windSpeed = '0';
  dynamic pressure = '0';
  // dynamic date = '';
  dynamic weather = 'loading...';

  IconData icon(String wtr) {
    if (wtr == 'Rain') {
      return Icons.cloudy_snowing;
    } else if (wtr == 'Clouds') {
      return Icons.cloud;
    } else if (wtr == 'Clear') {
      return Icons.wb_sunny;
    } else {
      return Icons.error;
    }
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    String location = 'Damak';
    String countrycode = 'NP';
    try {
      final result = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$location,$countrycode&APPID=$apikey'),
      );
      final data = jsonDecode(result.body);
      if (data['cod'] != '200') {
        throw 'unexpected error occured';
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCurrentWeather(),
      builder: (contex, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          if (snapshot.hasData) {
            data = snapshot.data as Map<String, dynamic>;
            final weatherdata = data['list'][0];
            temp = weatherdata['main']['temp'].toString();
            weather = weatherdata['weather'][0]['main'].toString();
            humidity = weatherdata['main']['humidity'].toString();
            windSpeed = weatherdata['wind']['speed'].toString();
            pressure = weatherdata['main']['pressure'].toString();
          } else {
            throw 'unexpected error occured';
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'Weather App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {});
                    },
                    radius: 10,
                    customBorder: const CircleBorder(),
                    child: const Icon(Icons.refresh),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 30,
                      right: 30,
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 25),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '$temp K',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Icon(
                                    icon(weather),
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    weather,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 32),
                    child: Text(
                      'Weather Forecast',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 130,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (contex, index) {
                        return CustContainer(
                          time: DateFormat.Hm().format(DateTime.parse(
                              data['list'][index + 1]['dt_txt'])),
                          icon: icon(
                              data['list'][index + 1]['weather'][0]['main']),
                          weather: data['list'][index + 1]['main']['temp']
                              .toString(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(left: 32),
                    child: Text(
                      'Additional Information',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AddInfo(
                          icon: Icons.water_drop,
                          data: 'Humidity',
                          amt: humidity.toString()),
                      AddInfo(
                          icon: Icons.air,
                          data: 'Wind Speed',
                          amt: windSpeed.toString()),
                      AddInfo(
                          icon: Icons.beach_access,
                          data: 'pressure',
                          amt: pressure.toString()),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
