import 'package:eliteemart/components/bottom_app_bar.dart';
import 'package:eliteemart/components/dash.dart';
import 'package:eliteemart/extras/colors.dart';
import 'package:eliteemart/pages/settings.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _index = 0;


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Offstage(
            offstage: _index != 0,
            child: new TickerMode(
              enabled: _index == 0,
              child: Dash(),
            ),
          ),
          Offstage(
            offstage: _index != 3,
            child: new TickerMode(
              enabled: _index == 3,
              child: Settings(),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        splashColor: AppColor.onBoardButtonColor,
        backgroundColor: Colors.white,
        onPressed: () {},
        tooltip: 'Your cart',
        child: Icon(
          Icons.fastfood,
          color: AppColor.onBoardButtonColorLight,
        ),
        elevation: 3,
      ),
      bottomNavigationBar: FABBottomAppBar(
        backgroundColor: Colors.white,
        selectedColor: AppColor.onBoardButtonColor,
        color: Colors.grey[500],
        onTabSelected: (int index) {
          if (index == 0) {
            setState(() {
              _index = 0;
            });
          } else if (index == 3) {
            setState(() {
              _index = 3;
            });
          }
        },
        notchedShape: CircularNotchedRectangle(),
        items: [
          FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
          FABBottomAppBarItem(
            iconData: Icons.search,
            text: 'Search',
          ),
          FABBottomAppBarItem(
            iconData: Icons.message,
            text: 'Message',
          ),
          FABBottomAppBarItem(
            iconData: Icons.person,
            text: 'Settings',
          ),
        ],
      ),
    );
  }
}
