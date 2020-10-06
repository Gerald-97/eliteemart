import 'package:eliteemart/components/widgets.dart';
import 'package:eliteemart/extras/colors.dart';
import 'package:eliteemart/methods/api_calls.dart';
import 'package:eliteemart/pages/dashboard.dart';
import 'package:eliteemart/pages/startup_pages/login.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _name;
  String _email;
  String _password;

  var val;
  bool isSignedUp = false;

  String error;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _myController = TextEditingController();

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
          margin: EdgeInsets.symmetric(vertical: 60, horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Sign Up',
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
                          labelText: 'Full Name',
                          hintStyle: TextStyle(
                            color: AppColor.loginFormFont,
                          ),
                        ),
                        validator: (name) {
                          if (name.length < 3)
                            return 'Invalid username';
                          else
                            return null;
                        },
                        onSaved: (name) => _name = name,
                      ),
                      SizedBox(
                        height: size.width / 9,
                      ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Already have an account? ',
                            style: TextStyle(color: Colors.black54),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColor.forgotPassword,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Login(),
                                    ),
                                  );
                                },
                            ),
                          ),
                        ],
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
                            registerNewUser();
                          }
                        },
                        color: isLoading
                            ? Colors.grey[400]
                            : AppColor.onBoardButtonColor,
                        title: isLoading ? 'Please wait...' : 'Sign Up',
                        textColor: isLoading ? Colors.black87 : Colors.white,
                      ),
                      SizedBox(
                        height: 25,
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
                                return Login();
                              },
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Text(
                          'I\'ll sign up later',
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

  dynamic registerNewUser() {
    {
      var registerUserResponse =
          ApiCall().registerUser(_name, _email, _password);
      registerUserResponse.then((response) async {
        setState(() {
          isLoading = false;
        });
        var statusCode = response['statusCode'];
        if (statusCode < 300 && response['status'] == 'Success') {
          print(response['data']);

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', response['data']['token']);

          showFlushBar(response['message']);

          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (context) {
                return Dashboard();
              },
            ), (Route<dynamic> route) => false);
          });
        } else {
          print('Response message is ${response['message']}');

          showFlushBar('Response message is ${response['message']}');
        }
      }).catchError((onError) {
        setState(() {
          isLoading = false;
        });
        error = ApiCall().handleRequestError(onError);
        showFlushBar(error);
      });
    }
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
