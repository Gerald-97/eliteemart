import 'package:eliteemart/extras/colors.dart';
import 'package:eliteemart/models/products.dart';
import 'package:eliteemart/pages/single_food.dart';
import 'package:flutter/material.dart';

Widget foodDashCard(BuildContext context, Food food) {
  var size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SingleFood(food),
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 2.0,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(
            food.image,
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            AppColor.onBoardButtonColorLight.withOpacity(0.2),
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Text(
                  food.foodName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.black87,
                  ),
                ),
                Text(
                  food.foodName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,

                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                Text(
                  food.vendor,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 0.7
                      ..color = Colors.black87,
                  ),
                ),
                Text(
                  food.vendor,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
