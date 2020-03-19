import 'package:eliteemart/extras/colors.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class SettingsMenu extends StatelessWidget {
  SettingsMenu({@required this.title, this.enterIcon, @required this.onTap});

  final String title;
  final bool enterIcon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    bool present = enterIcon ?? true;

    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 12,
          child: InkWell(
            onTap: onTap,
            splashColor: Colors.black26,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  present ? Icons.chevron_right : null,
                  size: 26,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: AppColor.loginFormFont,
          thickness: 1.5,
        ),
      ],
    );
  }
}

class LargeButton extends StatelessWidget {
  LargeButton({
    @required this.title,
    @required this.onPressed,
    this.color,
    this.textColor
  });

  final String title;
  final Function onPressed;
  final Color color;
  final textColor;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return FlatButton(
      onPressed: onPressed,
      splashColor: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: size.width / 3.5),
      color: color ?? AppColor.onBoardButtonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}

class AccountInfo extends StatelessWidget {
  AccountInfo(this.label, this.title);
  final String label, title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.black26),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class FlushBars extends StatelessWidget {
  final String message;

  FlushBars(this.message);
  @override
  Widget build(BuildContext context) {
    return
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

