import 'package:flutter/material.dart';

class NextDaysScreen extends StatefulWidget {
  @override
  _NextDaysScreenState createState() => _NextDaysScreenState();
}

class _NextDaysScreenState extends State<NextDaysScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Next 7 days',
          style: TextStyle(
            color: Color.fromRGBO(128,111,216, 1),
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700
          ),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color.fromRGBO(128,111,216, 1)),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Container(
            padding: EdgeInsets.all(34),
            margin: EdgeInsets.only(bottom: 32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end:  Alignment.topRight,
                colors: [
                  Color.fromRGBO(81,61,209, 1),
                  Color.fromRGBO(132, 106, 224, 1)
                ]
              ),
              borderRadius: BorderRadius.all(Radius.circular(24))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Today',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Nunito',
                        fontSize: 16
                      )
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 18, bottom: 10),
                      child: Text(
                        '23°',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 54,
                          fontWeight: FontWeight.w800
                        ),
                      )
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.keyboard_arrow_up,
                              color: Colors.white
                            ),
                            Text(
                              '26°',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                              ),
                            )
                          ]
                        ),
                        SizedBox(width: 12),
                        Row(
                          children: [
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white
                            ),
                            Text(
                              '18°',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                              ),
                            )
                          ]
                        )
                      ],
                    )
                  ],
                ),
                Icon(
                  Icons.cloud_outlined,
                  color: Colors.white,
                  size: 100
                )
              ],
            ),
          ),
          _buildPrevisionItem('Thursday'),
          _buildPrevisionItem('Friday'),
          _buildPrevisionItem('Saturday'),
          _buildPrevisionItem('Sunday'),
          _buildPrevisionItem('Monday'),
          _buildPrevisionItem('Tuesday'),
        ],
      )
    );
  }

  Widget _buildPrevisionItem(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 14, right: 14),
      child: Container(
        margin: EdgeInsets.only(bottom: 38),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Color.fromRGBO(117,124,147, 1),
                fontSize: 18,
                fontWeight: FontWeight.w700
              ),
            ),
            Row(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_up,
                      color: Color.fromRGBO(162,166,172, 1)
                    ),
                    Text(
                      '26°',
                      style: TextStyle(
                        color: Color.fromRGBO(162,166,172, 1),
                        fontSize: 18
                      ),
                    )
                  ]
                ),
                SizedBox(width: 14),
                Row(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Color.fromRGBO(162,166,172, 1)
                    ),
                    Text(
                      '18°',
                      style: TextStyle(
                        color: Color.fromRGBO(162,166,172, 1),
                        fontSize: 18
                      ),
                    )
                  ]
                )
              ],
            )
          ],
        )
      )
    );
  }
}