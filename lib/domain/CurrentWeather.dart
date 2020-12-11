import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:collection';

class CurrentWeather {
  final Map main;
  Map headers = HashMap<String, String>();

  CurrentWeather({this.main}) {
    headers['X-RapidAPI-Key'] = "824d1b4351msh8021e88aaf01a27p196addjsn6dd372e1cc9e";
    headers['X-RapidAPI-Host'] = "community-open-weather-map.p.rapidapi.com";
  }

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(main: json['main']);
  }

  Future<CurrentWeather> fetchCurrentWeather() async {
    final response = await http.get('https://community-open-weather-map.p.rapidapi.com/weather?q=Blumenau,br&units=metric', headers: headers);

    if (response.statusCode == 200) {
      return CurrentWeather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load current weather');
    }
  }
  
}