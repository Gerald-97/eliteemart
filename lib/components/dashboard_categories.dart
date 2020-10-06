import 'package:eliteemart/extras/colors.dart';
import 'package:eliteemart/models/subcategory.dart';
import 'package:eliteemart/pages/category_pages.dart';
import 'package:flutter/material.dart';

Widget showCategories(BuildContext context, Subcategory categories) {
  var size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoryPage(categories),
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: size.width / 1.5,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 8.0,
          ),
        ],
        borderRadius: BorderRadius.circular(20),
        color: AppColor.onBoardButtonColor,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Text(
                    categories.subCategoryName,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = .5
                        ..color = Colors.black54,
                    ),
                  ),
                  Text(
                    categories.subCategoryName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Stack(
                children: <Widget>[
                  Text(
                    categories.id.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = .5
                        ..color = Colors.black54,
                    ),
                  ),
                  Text(
                    categories.id.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
