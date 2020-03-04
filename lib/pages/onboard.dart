import 'package:eliteemart/extras/strings.dart';
import 'package:eliteemart/pages/sliding_pages_2.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int slideIndex;

  int pageLength;

  List<String> images = [
    Strings.slide_1_jpg,
    Strings.slide_2_jpg,
    Strings.slide_3_jpg
  ];

  List<String> titles = [
    Strings.slide_1_title,
    Strings.slide_2_title,
    Strings.slide_3_title
  ];

  List<String> subtitles = [
    Strings.slide_1_sub,
    Strings.slide_2_sub,
    Strings.slide_3_sub
  ];

  @override
  void initState() {
    // TODO: implement initState
    slideIndex = 0;
    pageLength = 3;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
              child: Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          PageView(
            children: <Widget>[
              SlidingPages2(images[0], titles[0], subtitles[0]),
              SlidingPages2(images[1], titles[1], subtitles[1]),
              SlidingPages2(images[2], titles[2], subtitles[2]),
            ],
            onPageChanged: (value) {
              setState(() {
                slideIndex = value;
              });
            },
          ),
        ],
      )
    );
  }
}
