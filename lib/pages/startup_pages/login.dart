import 'package:eliteemart/components/widgets.dart';
import 'package:eliteemart/extras/colors.dart';
import 'package:eliteemart/extras/constants.dart';
import 'package:eliteemart/methods/api_calls.dart';
import 'package:eliteemart/models/profiles.dart';
import 'package:eliteemart/pages/dashboard.dart';
import 'package:eliteemart/pages/startup_pages/signup.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _myController = TextEditingController();

  String _email;
  String _password;

  bool isLoading = false;
  bool isLoggedIn = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: !Navigator.canPop(context)
            ? null
            : BackButton(
                color: Colors.black54,
              ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.only(right: 10.0, top: 20),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintStyle: TextStyle(
                            color: AppColor.loginFormFont,
                          ),
                        ),
                        validator: (email) => EmailValidator.validate(email)
                            ? null
                            : 'Invalid Email',
                        onSaved: (email) => _email = email,
                      ),
                      SizedBox(
                        height: size.width / 9,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintStyle: TextStyle(
                            color: AppColor.loginFormFont,
                          ),
                        ),
                        validator: (password) {
                          if (password.length < 6) {
                            return 'Password must be more than 6 characters';
                          } else
                            return null;
                        },
                        onSaved: (password) => _password = password,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Forgot your password?',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColor.forgotPassword,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ),
                      SizedBox(
                        height: size.height / 9,
                      ),
                      LargeButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            setState(() {
                              isLoading = true;
                            });
                            loginUser();
                          }
                        },
                        color: isLoading
                            ? Colors.grey[400]
                            : AppColor.onBoardButtonColor,
                        title: isLoading ? 'Please wait...' : 'Sign In',
                        textColor: isLoading ? Colors.black87 : Colors.white,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Don\'t have an account? ',
                            style: TextStyle(color: Colors.black54),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColor.forgotPassword,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUp(),
                                    ),
                                  );
                                },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Divider(
                        color: AppColor.loginFormFont,
                        thickness: 1.5,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) {
                                return Dashboard();
                              },
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Text(
                          'I\'ll sign in later',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void loginUser() {
    var loginUserResponse = ApiCall().loginUser(_email, _password);
    loginUserResponse.then((response) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      setState(() {
        isLoading = false;
      });

      var responseCode = response['statusCode'];

      if (responseCode < 300 && response['status'] == 'Success') {

        Users userProfile = Users.getUserFromJson(response['data']);

        prefs.setString('token', userProfile.token);
        prefs.setInt(Constants.id, userProfile.id);
        prefs.setString(Constants.firstName, userProfile.firstName);
        prefs.setString(Constants.lastName, userProfile.lastName);
        prefs.setString(Constants.email, userProfile.email);
        prefs.setString('password', 'demopassword');

        showFlushBar(response['message']);

        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) {
              return Dashboard();
            },
          ), (Route<dynamic> route) => false);
        });
      } else {
        showFlushBar(response['message']);
      }
    }).catchError((onError) {
      setState(() {
        isLoading = false;
      });
      showFlushBar(ApiCall().handleRequestError(onError));
    });
  }

  void showFlushBar(String message) {
    Flushbar(
      messageText: Text(
        message,
        style: TextStyle(color: Colors.black87),
      ),
      borderColor: AppColor.onBoardButtonColorLight,
      backgroundColor: Colors.white70,
      duration: Duration(seconds: 3),
    )..show(context);
  }
}
