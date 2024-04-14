import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:weather_app/model.dart';

part 'weatherevent.dart';
part 'weatherstate.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherBlocState> {
  WeatherBloc() : super(InitStates()) {
    on<WeatherEvent>(
      (event, emit) => emit(
        Loading(),
      ),
    );
    on<GetWeaterData>(_getWeather);
    on<Refresh>(_refresh);
    on<ChangeLocation>(_changeLocation);
  }

  void _changeLocation(
      ChangeLocation event, Emitter<WeatherBlocState> emit) async {
    await _makeHttpRequest(
        event.location, event.countryCode, event.apiKey, emit);
  }

  void _refresh(Refresh event, Emitter<WeatherBlocState> emit) async {
    await _makeHttpRequest(
        event.location, event.countryCode, event.apiKey, emit);
  }

  void _getWeather(GetWeaterData event, Emitter<WeatherBlocState> emit) async {
    await _makeHttpRequest(
        event.location, event.countryCode, event.apiKey, emit);
  }

  Future<void> _makeHttpRequest(String location, String countryCode,
      String apiKey, Emitter<WeatherBlocState> emit) async {
    try {
      final res = await get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$location,$countryCode&APPID=$apiKey'),
      );
      final Map<String, dynamic> data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        emit(Failure(error: 'unexpected error occured'));
      } else {
        emit(
          Success(
            weather:
                List.generate(11, (index) => WeatherData.fromJson(data, index)),
          ),
        );
      }
    } catch (e) {
      log('failure');
      emit(Failure(error: e.toString()));
    }
  }
}
