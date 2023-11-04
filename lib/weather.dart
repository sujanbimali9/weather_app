import 'dart:ui';
import 'package:weather_app/container.dart';

import 'addinfo.dart';

import 'package:flutter/material.dart';

class WeatherUI extends StatefulWidget {
  const WeatherUI({super.key});

  @override
  State<WeatherUI> createState() => _WeatherUIaState();
}

class _WeatherUIaState extends State<WeatherUI> {
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {},
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
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '300.67 k',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Icon(
                              Icons.cloud,
                              color: Colors.white,
                              size: 60,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Rain',
                              style: TextStyle(
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
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  CustContainer(
                    time: '09:00',
                    icon: Icons.cloud,
                    weather: '302.17',
                  ),
                  CustContainer(
                    time: '09:00',
                    icon: Icons.cloud,
                    weather: '302.17',
                  ),
                  CustContainer(
                    time: '09:00',
                    icon: Icons.cloud,
                    weather: '302.17',
                  ),
                  CustContainer(
                    time: '09:00',
                    icon: Icons.cloud,
                    weather: '302.17',
                  ),
                  CustContainer(
                    time: '09:00',
                    icon: Icons.cloud,
                    weather: '302.17',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AddInfo(icon: Icons.water_drop, data: 'Humidity', amt: '90'),
                AddInfo(icon: Icons.air, data: 'Wind Speed', amt: '7.67'),
                AddInfo(icon: Icons.beach_access, data: 'pressure', amt: '90')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
