import 'package:eliteemart/extras/strings.dart';
import 'package:flutter/material.dart';

class SlidingPages2 extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  SlidingPages2(this.image, this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        child: Column(
          children: <Widget>[
            ClipRRect(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
//              width: double.infinity,
                height: MediaQuery.of(context).size.height/2.5,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            SizedBox(
              height: 35,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 30,
                  fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              subtitle,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            Align(
              alignment: Alignment.center,
              child: FlatButton(
                onPressed: () {},
                child: Text('Continue'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
