import 'package:eliteemart/extras/strings.dart';
import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class SlidingPages extends StatefulWidget {
  @override
  _SlidingPagesState createState() => _SlidingPagesState();
}

class _SlidingPagesState extends State<SlidingPages> {
  int _slideIndex = 0;

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

  final IndexController controller = IndexController();
  @override
  Widget build(BuildContext context) {
    TransformerPageView transformerPageView = TransformerPageView(
      pageSnapping: true,
      onPageChanged: (index) {
        setState(() {
          this._slideIndex = index;
        });
      },
      loop: false,
      controller: controller,
      transformer:
          PageTransformerBuilder(builder: (Widget child, TransformInfo info) {
        return Material(
          color: Colors.white,
          elevation: 8,
          textStyle: TextStyle(color: Colors.white),
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ParallaxContainer(
                    child: Image.asset(
                      images[info.index],
                      fit: BoxFit.contain,
                      height: 300,
                    ),
                    position: info.position,
                    translationFactor: 400,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ParallaxContainer(
                    child: Text(
                      titles[info.index],
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    position: info.position,
                    translationFactor: 400,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ParallaxContainer(
                    child: Text(
                      subtitles[info.index],
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    position: info.position,
                    translationFactor: 300,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
      itemCount: 3,
    );

    return transformerPageView;
  }
}
