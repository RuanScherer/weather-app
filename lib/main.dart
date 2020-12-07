import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white
      )
    );
    
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(81,61,209, 1),
        accentColor: Color.fromRGBO(81,61,209, 1),
        fontFamily: 'Epilogue'
      ),
      home: MainScreen()
    );
  }
}
