import 'package:eliteemart/components/widgets.dart';
import 'package:eliteemart/extras/colors.dart';
import 'package:eliteemart/models/product.dart';
import 'package:eliteemart/models/products.dart';
import 'package:eliteemart/models/subcategory.dart';
import 'package:flutter/material.dart';

class SingleFood extends StatefulWidget {
  final ProductElement item;

  SingleFood(this.item);

  @override
  _SingleFoodState createState() => _SingleFoodState();
}

class _SingleFoodState extends State<SingleFood> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: BackButton(
          color: Colors.black54,
        ),
        title: Text(
          'E-Mart!',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: LargeButton(
          title: 'ADD TO CART',
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: size.height / 3.5,
                  ),
                  Center(
                    child: Container(
                      width: size.width / 1.1,
                      height: size.height / 4,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 10.0,
                          ),
                        ],
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.item.productAvatar,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
//                  Container(
//                    height: size.height / 3.2,
//                    child: Align(
//                      alignment: Alignment.bottomCenter,
//                      child: Card(
//                        elevation: 3,
//                        borderOnForeground: false,
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(5),
//                          side: BorderSide(
//                            color: AppColor.onBoardButtonColor,
//                            width: 2,
//                          ),
//                        ),
//                        color: Colors.white,
//                        child: Container(
//                          width: size.width / 4,
//                          height: size.height / 10,
//                          child: Card(
//                            elevation: 0,
//                            shape: CircleBorder(),
//                            child: Image.network(
//                              widget.item.productAvatar,
//                              fit: BoxFit.cover,
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: AppColor.onBoardButtonColorLight,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  widget.item.productName,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Price tag',
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.black54
                      ),
                    ),
                    Text(
                      widget.item.productPrice,
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: AppColor.onBoardButtonColor
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  widget.item.slug,
                  style: TextStyle(fontSize: 16, height: 1.6, color: Colors.black54),
                ),
              ),
              Divider(
                color: AppColor.onBoardButtonColorLight,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Quantity in stock',
                      style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          color: Colors.black54
                      ),
                    ),
                    Text(
                      widget.item.productQuantity.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          color: AppColor.onBoardButtonColor
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//  Stack(
//  children: <Widget>[
//  Text(
//  widget.food.vendor,
//  style: TextStyle(
//  color: AppColor.onBoardButtonColor,
//  ),
//  ),
//  Text(
//  widget.food.vendor,
//  style: TextStyle(
//  foreground: Paint()
//  ..style = PaintingStyle.stroke
//  ..strokeWidth = 0.1
//  ..color = Colors.black87,
//  ),
//  ),
//  ],
//  ),

}
