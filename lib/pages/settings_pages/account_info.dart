import 'dart:io';
import 'dart:async';
import 'package:eliteemart/extras/colors.dart';
import 'package:eliteemart/methods/api_calls.dart';
import 'package:eliteemart/models/profiles.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountSettings extends StatefulWidget {
  final Users user;

  AccountSettings(this.user);

  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  Users user;
  bool autoValidate = false;
  int _id;
  String _token;
  String _newPassword;

  bool _isLoading = false;
  File _image;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String validatePassword(String value) {
    if (value != null && value.length < 6) {
      return 'Password is short';
    }
  }

  Future getImage(imgSelect) async {
    var image;
    if (imgSelect == 'camera') {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else if (imgSelect == 'gallery') {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      _image = image;
    });
  }

  void getInfo() {
    _id = widget.user.id;
    _token = widget.user.token;
  }

  @override
  void initState() {
    user = widget.user;
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black54,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Account Details',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidate: autoValidate,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: size.height / 7,
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: <Widget>[
                            Card(
                              elevation: 0,
                              clipBehavior: Clip.antiAlias,
                              shape: CircleBorder(),
                              child: Container(
                                child: _image != null
                                    ? Image.file(
                                        _image,
                                        fit: BoxFit.cover,
                                      )
                                    : CircleAvatar(
                                        radius: double.infinity,
                                        backgroundColor: Colors.black12,
                                      ),
                              ),
                            ),
                            Center(
                              child: _image == null
                                  ? Icon(
                                      Icons.camera_front,
                                      size: size.width / 8,
                                      color: Colors.black54,
                                    )
                                  : null,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: size.width / 1.5,
                                child: FlatButton(
                                  shape: CircleBorder(),
                                  onPressed: () {
                                    chooseImage(context);
                                  },
                                  splashColor: Colors.white70,
                                  color: AppColor.onBoardButtonColor,
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'First Name',
                              ),
                              initialValue: widget.user.firstName,
                              validator: (name) {
                                if (name.length < 3)
                                  return 'Invalid username';
                                else
                                  return null;
                              },
                              onSaved: (value) => user.firstName = value,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Last Name',
                              ),
                              initialValue: widget.user.lastName,
                              validator: (name) {
                                if (name.length < 3)
                                  return 'Invalid username';
                                else
                                  return null;
                              },
                              onSaved: (name) => user.lastName = name,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                          initialValue: widget.user.email,
                          validator: (email) => EmailValidator.validate(email)
                              ? null
                              : 'Invalid Email',
                          onSaved: (email) => user.email = email,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Divider(
                          color: AppColor.onBoardButtonColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 50.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                          ),

                          onSaved: (password) => _newPassword = password,
                          obscureText: true,
                        ),
                      ),
                      Center(
                        child: FlatButton(
                          onPressed: () {
                            final FormState form = _formKey.currentState;
                            if (!form.validate()) {
                              setState(() {
                                autoValidate = true;
                              });
                            } else {
                              form.save();
                              setState(() {
                                _isLoading = true;
                              });
                              callUpdate();
                            }
                          },
                          child: Text(
                            _isLoading ? 'Please wait...' : 'UPDATE',
                            style: TextStyle(
                              color: AppColor.onBoardButtonColor,
                            ),
                          ),
                          splashColor: AppColor.onBoardButtonColorLight,
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: size.width / 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(
                              color: AppColor.onBoardButtonColor,
                              width: 2,
                            ),
                          ),
                          color: _isLoading ? Colors.grey[200] : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void chooseImage(context) {
    PlatformActionSheet().displaySheet(
      context: context,
      title: Text(
        'Choose image',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      message: Text('Your options are'),
      actions: [
        ActionSheetAction(
          text: "Camera",
          onPressed: () async {
            getImage('camera');
            Navigator.pop(context);
          },
        ),
        ActionSheetAction(
          text: "Gallery",
          onPressed: () async {
            getImage('gallery');
            Navigator.pop(context);
          },
        ),
        ActionSheetAction(
          text: "Cancel",
          onPressed: () => Navigator.pop(context),
          isCancel: true,
          defaultAction: true,
        )
      ],
    );
  }

  void callUpdate() async {
    if (widget.user.toString() != user.toString()) {
       updateProfile();
    }

    if (_newPassword != null && _newPassword.length > 0) {
      if(_newPassword.length<6){
        showFlushBar("password is short");
      }
      else{
         updatePassword();
      }

    }
  }

  Future updateProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = _id;
    String token = _token;

    var updateUserResponse = ApiCall().updateUserProfile(
        id, user.firstName, user.lastName, user.email, token);
    updateUserResponse.then((response) {
      setState(() {
        _isLoading = false;
      });
      var responseCode = response['statusCode'];
      if (responseCode < 300) {
        prefs.setString("firstname", user.firstName);
        prefs.setString('lastname', user.lastName);
        prefs.setString('email', user.email);

        showFlushBar(response['message']);
        Navigator.pop(context);
      } else {
        showFlushBar(response['message']);
      }
    });
  }

  Future updatePassword() async {
    String password = _newPassword;
    int id = _id;
    String token = _token;

    var updateUserPassword = ApiCall().updateUserPassword(id, password, token);
    updateUserPassword.then((response) async {
      setState(() {
        _isLoading = false;
        var responseCode = response['statusCode'];

        if (responseCode < 300) {
          Navigator.pop(context);
          showFlushBar(response['message']);
        } else {
          showFlushBar(response['message']);
        }
      });
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
