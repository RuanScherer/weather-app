import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:collection';

class ForecastPerHours {
  final List list;
  Map headers = HashMap<String, String>();

  ForecastPerHours({this.list}) {
    headers['X-RapidAPI-Key'] = "824d1b4351msh8021e88aaf01a27p196addjsn6dd372e1cc9e";
    headers['X-RapidAPI-Host'] = "community-open-weather-map.p.rapidapi.com";
  }

  factory ForecastPerHours.fromJson(Map<String, dynamic> json) {
    return ForecastPerHours(list: json['list']);
  }

  Future<ForecastPerHours> fetchForecastPerHours() async {
    final response = await http.get('https://community-open-weather-map.p.rapidapi.com/forecast?q=Blumenau,br&units=metric', headers: headers);

    if (response.statusCode == 200) {
      return ForecastPerHours.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load forecast per hours');
    }
  }
  
}