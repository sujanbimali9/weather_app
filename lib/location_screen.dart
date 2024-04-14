import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/.key.dart';
import 'package:weather_app/bloc/weatherbloc.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

Future<List<Map<String, dynamic>>> loadJsonFromAssets(String filePath) async {
  String jsonString = await rootBundle.loadString(filePath);
  return jsonDecode(jsonString).cast<Map<String, dynamic>>();
}

class _LocationScreenState extends State<LocationScreen> {
  List<Map<String, dynamic>> locations = [];

  void loadLocations() async {
    locations = await loadJsonFromAssets('assets/location.json');
    setState(() {});
  }

  @override
  void initState() {
    loadLocations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    context.read<WeatherBloc>().add(ChangeLocation(
                        location: locations[index]['name'],
                        apiKey: apikey,
                        countryCode: locations[index]['country']));

                    Navigator.pop(context);
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
            );
          },
        ),
      ),
    );
  }
}
