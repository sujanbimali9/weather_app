import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/location.dart';

import 'controller.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Controller controller = Get.put(Controller());
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  controller.loaction = locations[index]['name'].toString().obs;
                  controller.country =
                      locations[index]['country'].toString().obs;
                  Navigator.pushNamed(
                    context,
                    '/home',
                  );
                },
                title: Center(
                  child: Text(
                      'Country code : ${locations[index]['country'].toString()}'),
                ),
                subtitle: Center(
                  child: Text(
                    'places : ${locations[index]['name'].toString()}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
