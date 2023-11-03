import 'package:flutter/material.dart';

class WeatherUI extends StatefulWidget {
  const WeatherUI({super.key});

  @override
  State<WeatherUI> createState() => _WeatherUIaState();
}

class _WeatherUIaState extends State<WeatherUI> {
  Widget addInfo(
      {required IconData icon, required String data, required String amt}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.white,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            data,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            amt.toString(),
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget container(
      {required String time, required IconData icon, required String weather}) {
    return Container(
      alignment: Alignment.center,
      height: 120,
      width: 100,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 88, 81, 81),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            time,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(
            height: 8,
          ),
          Icon(
            icon,
            color: Colors.white,
            size: 40,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            weather,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 47, 40, 40),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 47, 40, 40),
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
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
            style: IconButton.styleFrom(iconSize: 3),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Container(
            height: 175,
            width: 350,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 88, 81, 81),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  '300.67 F',
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
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                container(time: '09:00', icon: Icons.cloud, weather: '302.17'),
                const SizedBox(
                  width: 5,
                ),
                container(time: '09:00', icon: Icons.cloud, weather: '302.17'),
                const SizedBox(
                  width: 5,
                ),
                container(time: '09:00', icon: Icons.cloud, weather: '302.17'),
                const SizedBox(
                  width: 5,
                ),
                container(time: '09:00', icon: Icons.cloud, weather: '302.17'),
                const SizedBox(
                  width: 5,
                ),
                container(time: '09:00', icon: Icons.cloud, weather: '302.17'),
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
          Row(
            children: [
              addInfo(icon: Icons.water_drop, data: 'Humidity', amt: '90'),
              addInfo(icon: Icons.air, data: 'Wind Speed', amt: '7.67'),
              addInfo(icon: Icons.beach_access, data: 'pressure', amt: '90'),
            ],
          )
        ],
      ),
    );
  }
}
