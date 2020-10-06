import 'package:flutter/material.dart';

class SlidingPages extends StatefulWidget {

  final String image;
  final String title;
  final String subtitle;


  SlidingPages(this.image, this.title, this.subtitle);

  @override
  _SlidingPagesState createState() => _SlidingPagesState();
}

class _SlidingPagesState extends State<SlidingPages> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: size.height / 8, horizontal: 30),
      child: Column(
        children: <Widget>[
          ClipRRect(
            child: Image.asset(
              widget.image,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height / 2.5,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          SizedBox(
            height: 35,
          ),
          Text(
            widget.title,
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
            widget.subtitle,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
