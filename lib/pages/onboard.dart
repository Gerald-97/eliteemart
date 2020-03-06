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
        Container(
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  FlatButton(
                      onPressed: () {},
                      splashColor: Colors.blueGrey,
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ))
                ],
              )),
        ),
        PageView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return SlidingPages2(
                images[index], titles[index], subtitles[index]);
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 120,
            alignment: Alignment.topCenter,
            child: FlatButton(
              onPressed: () {},
              child: Text(
                'Continue',
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
