import 'dart:convert';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/container.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/controller.dart';
import 'addinfo.dart';
import '.key.dart';
import 'package:flutter/material.dart';

class WeatherUI extends StatefulWidget {
  const WeatherUI({
    super.key,
  });
  @override
  State<WeatherUI> createState() => _WeatherUIaState();
}

class _WeatherUIaState extends State<WeatherUI> {
  dynamic data;
  double temp = 0;
  dynamic humidity = '0';
  dynamic windSpeed = '0';
  dynamic pressure = '0';
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

  Future<Map<String, dynamic>> getCurrentWeather(
      String location, String countrycode) async {
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
    Controller controller = Get.put(Controller());
    String location = controller.loaction.value;
    String countrycode = controller.country.value;
    return FutureBuilder(
      future: getCurrentWeather(location, countrycode),
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
            temp = weatherdata['main']['temp'];
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
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/location');
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      // color: const Color.fromARGB(255, 66, 66, 66)
                      // .withOpacity(0.3),
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      margin: const EdgeInsets.only(
                        right: 20,
                        left: 20,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 5),
                            child: Row(
                              children: [
                                Text(
                                  location,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        getCurrentWeather(location, countrycode);
                      });
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
                  Container(
                    padding: const EdgeInsets.only(
                      top: 7,
                      left: 30,
                      right: 30,
                    ),
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
                                  height: 5,
                                ),
                                Icon(
                                  icon(weather),
                                  color: Colors.white,
                                  size: 60,
                                ),
                                const SizedBox(
                                  height: 5,
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 32),
                    child: Text(
                      'Hourly Forecast',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (data != null)
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
