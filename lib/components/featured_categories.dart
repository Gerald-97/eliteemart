import 'package:eliteemart/extras/colors.dart';
import 'package:eliteemart/models/product.dart';
import 'package:eliteemart/pages/single_item.dart';
import 'package:flutter/material.dart';

Widget foodDashCard(BuildContext context, ProductElement item) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SingleFood(item),
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
          image: NetworkImage(
            item.productAvatar ??
                'https://www.cowgirlcontractcleaning.com/wp-content/uploads/sites/360/2018/05/placeholder-img-4.jpg',
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
                  item.productName,
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
                  item.productName,
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
          ],
        ),
      ),
    ),
  );
}
