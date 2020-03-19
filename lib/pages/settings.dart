import 'package:eliteemart/components/widgets.dart';
import 'package:eliteemart/extras/colors.dart';
import 'package:eliteemart/extras/constants.dart';
import 'package:eliteemart/models/profiles.dart';
import 'package:eliteemart/pages/startup_pages/login.dart';
import 'package:eliteemart/pages/settings_pages/account_info.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Users _user;

  bool _isLoggedIn = false;

  void getNames() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _user = Users(
      prefs.getInt(Constants.id) ?? null,
      prefs.getString(Constants.firstName),
      prefs.getString(Constants.lastName),
      prefs.getString(Constants.email),
      prefs.getString('token'),
    );
    getInfo();
  }

  void getInfo() {

    setState(() {
      _isLoggedIn = _user.token != null ? true : false;
    });
  }

  @override
  void initState() {
    getNames();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'E-Mart!',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                _isLoggedIn
                    ? FlatButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.clear();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) {
                            return Login();
                          }), (Route<dynamic> route) => false);
                        },
                        splashColor: AppColor.onBoardButtonColorLight,
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width / 13,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(
                            color: AppColor.onBoardButtonColor,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColor.onBoardButtonColor,
                          ),
                        ),
                      )
                    : FlatButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.clear();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                        },
                        splashColor: Colors.white70,
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width / 13,
                        ),
                        color: AppColor.onBoardButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SettingsMenu(
                      title: 'Account Details',
                      onTap: () {
                        _isLoggedIn
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AccountSettings(_user),
                                ),
                              )
                            : showFlushBar('You need to be logged in');
                      },
                    ),
                    SettingsMenu(
                      title: 'Shipping',
                      onTap: () {},
                    ),
                    SettingsMenu(
                      title: 'Payment',
                      onTap: () {},
                    ),
                    SettingsMenu(
                      title: 'Support',
                      onTap: () {},
                    ),
                    SettingsMenu(
                      title: 'Terms & Conditions',
                      onTap: () {},
                    ),
                    SettingsMenu(
                      title: 'My Data',
                      onTap: () {},
                    ),
                    SettingsMenu(
                      title: 'Other',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showFlushBar(String message) {
    Flushbar(
      borderColor: AppColor.onBoardButtonColorLight,
      backgroundColor: Colors.white70,
      messageText: Text(
        message,
        style: TextStyle(color: Colors.black87),
      ),
      duration: Duration(seconds: 3),
    )..show(context);
  }
}
