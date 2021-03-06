import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/CurrentWeather.dart';
import 'package:weather_app/domain/ForecastPerHours.dart';
import 'next.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _menuIsCollapsed = true;
  double screenWidth, screenHeight;
  Duration duration = Duration(milliseconds: 400);
  String weekday, message;
  int hour;
  Future<CurrentWeather> currentWeather;
  Future<ForecastPerHours> forecastPerHours;

  @override
  void initState() {
    super.initState();
    currentWeather = CurrentWeather().fetchCurrentWeather();
    forecastPerHours = ForecastPerHours().fetchForecastPerHours();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    screenWidth = _size.width;
    screenHeight = _size.height;

    DateTime date = DateTime.now();
    weekday = DateFormat.MMMMEEEEd().format(date);
    hour = date.hour;

    if (hour < 12) {
      this.message = "Good Morning";
    } else if (hour < 17) {
      this.message = "Good Afternoon";
    } else {
      this.message = "Good Evening";
    }

    return SafeArea(
      child: Stack(
        children:[
          _buildMenu(),
          _buildHome()
        ]
      )
    );
  }

  Widget _buildHome() {
    final _additionalTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white70,
    );
    final _radius = Radius.circular(40);
    final _shadow = BoxShadow(
      color: Color.fromRGBO(225,217,248, 1),
      blurRadius: 24,
      spreadRadius: 4
    );

    return FutureBuilder(
      future: Future.wait([currentWeather, forecastPerHours]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Material(
            child: Center(
              heightFactor: screenHeight,
              widthFactor: screenWidth,
              child: CircularProgressIndicator()
            )
          );
        }

        Map main = snapshot.data[0].main;

        return AnimatedPositioned(
          height: screenHeight - 20,
          duration: duration,
          left: _menuIsCollapsed ? 0 : screenWidth * -0.75,
          right: _menuIsCollapsed ? 0 : screenWidth * 0.75,
          child: Material(
            borderRadius: _menuIsCollapsed ? null : BorderRadius.only(bottomRight: _radius, topRight: _radius),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end:  Alignment.topRight,
                  colors: [
                    Color.fromRGBO(81,61,209, 1),
                    Color.fromRGBO(132, 106, 224, 1)
                  ]
                ),
                borderRadius: _menuIsCollapsed ? null : BorderRadius.only(bottomRight: _radius, topRight: _radius),
                boxShadow: [ _shadow, _shadow, _shadow, _shadow ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,            
                children: [
                  Container(
                    padding: EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                              )
                            )
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            _menuIsCollapsed ? Icons.menu_rounded : Icons.close_rounded,
                            color: Colors.white,
                            size: 38
                          ),
                          onPressed: () {
                            setState(() {
                              _menuIsCollapsed = !_menuIsCollapsed;
                            });
                          },
                          color: Colors.white
                        )
                      ]
                    )
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Blumenau',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                          )
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 4, 0, 30),
                          child: Text(
                            weekday,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w200,
                              color: Colors.white70,
                              fontFamily: 'Nunito'
                            )
                          )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 30),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_up,
                                    color: Colors.white70,
                                    size: 20,
                                  ),
                                  Text(
                                    formatTemperature(main['temp_max']),
                                    style: _additionalTextStyle,
                                  )
                                ]
                              )
                            ),
                            Text(
                              formatTemperature(main['temp']),
                              style: TextStyle(
                                fontSize: 64,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Row(
                                children: [
                                  Text(
                                    formatTemperature(main['temp_min']),
                                    style: _additionalTextStyle,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white70,
                                    size: 20,
                                  )
                                ]
                              )
                            ),
                          ]
                        )
                      ],
                    ),      
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 28,
                      bottom: 40,
                      left: 24,
                      right: 24
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: _radius, 
                        topRight: _radius,
                        bottomRight: _menuIsCollapsed ? Radius.zero : _radius
                      )
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Today',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 18,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              TextButton(
                                child: Text(
                                  'Next 7 days',
                                  style: TextStyle(
                                    color: Color.fromRGBO(128,111,216, 1),
                                    fontSize: 16,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) {
                                        return NextDaysScreen();
                                      }
                                    )
                                  );
                                },
                              ),
                            ]
                          )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _buildForecastItems(snapshot.data[1].list),
                        ),
                      ]
                    )
                  )
                ],
              ),
            )
          )
        );
      }
    );
  }

  Widget _buildMenu() {
     var commonText = (String text) => (
      Container(
        margin: EdgeInsets.only(top: 14, bottom: 14),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            fontFamily: 'Nunito',
            color: Color.fromRGBO(176, 106, 247, 1)
          ),
          textAlign: TextAlign.right,
        )
      )
    );

    return Material(
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            commonText('Weather App'),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 14, bottom: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Blumenau',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Nunito',
                              color: Color.fromRGBO(129, 14, 247, 1)
                            ),
                            textAlign: TextAlign.right,
                          ),
                          Text(
                            'Santa Catarina',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Nunito',
                              color: Color.fromRGBO(199,198,204, 1)
                            ),
                            textAlign: TextAlign.right,
                          )
                        ]
                      )
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.location_pin,
                        color: Color.fromRGBO(129, 14, 247, 1),
                        size: 26
                      )
                    )
                  ]
                ),
                Container(
                  margin: EdgeInsets.only(top: 14, bottom: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'New city',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Nunito',
                          color: Color.fromRGBO(149, 152, 156, 1)
                        ),
                        textAlign: TextAlign.right,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.add_circle_outline_outlined,
                          color: Color.fromRGBO(149, 152, 156, 1),
                          size: 26
                        )
                      )
                    ]
                  )
                )
              ],
            ),
            commonText('By Ruan Scherer')
          ],
        )
      )
    );
  }

  List<Widget> _buildForecastItems(List forecastList) {
    final _textStyle = TextStyle(
      color: Colors.grey,
      fontSize: 14,
      fontFamily: 'Nunito'
    );

    List<Widget> forecastItems = List<Widget>();
    
    forecastItems = forecastList.getRange(0, 5).map<Widget>((forecast) {
      DateTime forecastDate = DateTime.parse(forecast['dt_txt']);
      String forecastHour = DateFormat.Hm().format(forecastDate);
      
      return Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(226,227,228, 1)),
              borderRadius: BorderRadius.all(Radius.circular(16))
            ),
            child: Center(
              child: Column(
                children: [
                  Text(
                    forecastHour,
                    style: _textStyle,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10
                    ),
                    child: Icon(
                      Icons.cloud_outlined,
                      color: Colors.grey,
                      size: 32
                    )
                  ),
                  Text(
                    formatTemperature(forecast['main']['temp']),
                    style: _textStyle,
                  )
                ],
              ),
            )
          )
        ],
      );
    }).toList();

    return forecastItems;
  }

  String formatTemperature(double temperature) {
    return temperature.toInt().toString() + '°';
  }
}