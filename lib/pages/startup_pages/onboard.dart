import 'package:eliteemart/components/widgets.dart';
import 'package:eliteemart/extras/colors.dart';
import 'package:eliteemart/extras/strings.dart';
import 'package:eliteemart/pages/startup_pages/login.dart';
import 'package:eliteemart/pages/startup_pages/sliding_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  final PageController pageController = PageController();

  int slideIndex;

  bool hasUsedApp = false;

  bool lastPage;

  int pageLength;
  var page;
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
    lastPage = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageIndicatorContainer(
            child: PageView.builder(
              itemCount: pageLength,
              controller: pageController,
              itemBuilder: (context, index) {
                SchedulerBinding.instance.addPostFrameCallback(
                  (_) => setState(
                    () {
                      page = index;
                    },
                  ),
                );
                //print("page is $page");
                return SlidingPages(
                  images[index],
                  titles[index],
                  subtitles[index],
                );
              },
            ),
            align: IndicatorAlign.bottom,
            length: 3,
            indicatorSpace: 13.0,
            padding: EdgeInsets.only(bottom: size.height / 6),
            indicatorColor: AppColor.onBoardSelectInactive,
            indicatorSelectorColor: AppColor.onBoardSelectActive,
            shape: IndicatorShape.circle(size: 8),
          ),
          Container(
            height: size.height / 9,
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
                    onPressed: () {
                      finishOnboarding();
                    },
                    splashColor: Colors.blueGrey,
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height / 9,
              alignment: Alignment.topCenter,
              child: LargeButton(
                  title: page != 2 ? 'Continue' : 'Get Started',
                  onPressed: () {
                    if (page != 2) {
                      pageController.nextPage(
                        duration: Duration(
                          milliseconds: 100,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    } else {
                      finishOnboarding();
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }

  void finishOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    hasUsedApp = true;
    prefs.setBool('hasUsedApp', hasUsedApp);

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) {
          return Login();
        },
      ),
      (Route<dynamic> route) => false,
    );
  }
}
