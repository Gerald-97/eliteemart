import 'package:eliteemart/pages/dashboard.dart';
import 'package:eliteemart/pages/startup_pages/login.dart';
import 'package:eliteemart/pages/startup_pages/onboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool hasUsedApp =
      (await SharedPreferences.getInstance()).getBool("hasUsedApp") ?? false;

  bool isToken = false;

//TODO: Shrink to a single line
  String token = (await SharedPreferences.getInstance()).getString("token");
  if (token != null) {
    isToken = true;
  }

  runApp(EMart(hasUsedApp, isToken));
}

class EMart extends StatefulWidget {
  final bool hasUsedApp;
  final bool isToken;

  EMart(this.hasUsedApp, this.isToken);
  // This widget is the root of your application.
  @override
  _EMartState createState() => _EMartState();
}

class _EMartState extends State<EMart> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: !widget.hasUsedApp
          ? OnBoard()
          : widget.isToken ? Dashboard() : Login(),
    );
  }
}
