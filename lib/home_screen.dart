import 'dart:developer';
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/.key.dart';
import 'package:weather_app/bloc/weatherbloc.dart';
import 'package:weather_app/container.dart';

import 'addinfo.dart';
import 'package:flutter/material.dart';

class WeatherUI extends StatefulWidget {
  const WeatherUI({
    super.key,
  });
  @override
  State<WeatherUI> createState() => _WeatherUIState();
}

class _WeatherUIState extends State<WeatherUI> {
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

  late String location;
  late String countryCode;

  @override
  void initState() {
    countryCode = 'NP';
    location = "Damak";
    context.read<WeatherBloc>().add(GetWeaterData(
        apiKey: apikey, countryCode: countryCode, location: location));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    side: BorderSide(width: 0.1),
                    borderRadius: BorderRadius.all(Radius.circular(5)))),
            onPressed: () async {
              await Navigator.pushNamed(context, '/location');
            },
            child: BlocSelector<WeatherBloc, WeatherBlocState, String>(
              selector: (state) {
                if (state is Success) {
                  return state.weather.first.location;
                } else {
                  return 'Location';
                }
              },
              builder: (context, state) {
                return Text(
                  state,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                );
              },
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<WeatherBloc>().add(Refresh(
              location: location, apiKey: apikey, countryCode: countryCode));
          Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: AlwaysScrollableScrollPhysics(),
          child: BlocBuilder<WeatherBloc, WeatherBlocState>(
            builder: (context, state) {
              if (state is Failure) {
                return const SizedBox();
              } else if (state is Loading || state is InitStates) {
                return const Center(
                  child: RefreshProgressIndicator(),
                );
              } else if (state is Success) {
                final currentWeather = state.weather[0];
                countryCode = currentWeather.countryCode;
                location = currentWeather.location;
                return Column(
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
                                    '${currentWeather.temperature} K',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Icon(
                                    icon(currentWeather.weather),
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    currentWeather.weather,
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
                    SizedBox(
                      height: 130,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (contex, index) {
                          final weather = state.weather[index + 1];
                          return CustContainer(
                            time: weather.time,
                            icon: icon(weather.weather),
                            temp: weather.temperature,
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
                            amt: currentWeather.humidity.toString()),
                        AddInfo(
                            icon: Icons.air,
                            data: 'Wind Speed',
                            amt: currentWeather.windSpeed.toString()),
                        AddInfo(
                            icon: Icons.beach_access,
                            data: 'pressure',
                            amt: currentWeather.pressure.toString()),
                      ],
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
