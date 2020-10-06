import 'package:eliteemart/extras/colors.dart';
import 'package:eliteemart/extras/constants.dart';
import 'package:eliteemart/methods/api_calls.dart';
import 'package:eliteemart/models/cart.dart';
import 'package:eliteemart/models/cart_send_model.dart';
import 'package:eliteemart/models/product.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:numberpicker/numberpicker.dart';

class SingleFood extends StatefulWidget {
  final ProductElement item;

  SingleFood(this.item);

  @override
  _SingleFoodState createState() => _SingleFoodState();
}

class _SingleFoodState extends State<SingleFood> {
  RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  Function mathFunc = (Match match) => '${match[1]},';

  List cartItemList = [];

  Map<String, dynamic> cartItem;

  List<ProductElement> cartList = [];

  int _orderQtyValue = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
        padding: const EdgeInsets.only(bottom: 10.0),
        child: FlatButton(
          onPressed:
//              CartFile.addItemsById.containsKey(widget.item.id.toString())
//                  ? null
//                  :
              () {
//                      CartFile.addItemsById.putIfAbsent(
//                        widget.item.id.toString(),
//                        () => [
//                          widget.item.id.toString(),
//                          widget.item.productName,
//                          widget.item.productAvatar,
//                          widget.item.productPrice,
//                        ],
//                      );
            addToCart();
          },
          padding: EdgeInsets.symmetric(vertical: 10),
          color: AppColor.onBoardButtonColor,
          disabledColor: Colors.grey,
          splashColor: Colors.white70,
          child: Text(
            CartFile.addItemsById.containsKey(widget.item.id.toString())
                ? 'Added to Cart'
                : 'Add to Cart',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
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
                      height: size.height / 3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.item.productAvatar,
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
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
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      '₦${widget.item.productPrice}',
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: AppColor.onBoardButtonColor,
                      ),
                    ),
                  ],
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
                          color: Colors.black54),
                    ),
                    Text(
                      widget.item.productQuantity.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          color: AppColor.onBoardButtonColor),
                    ),
                  ],
                ),
              ),
              Divider(
                color: AppColor.onBoardButtonColorLight,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Order quantity',
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.black54),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Card(
                          clipBehavior: Clip.antiAlias,
                          child: NumberPicker.integer(
                            itemExtent: 40,
                            listViewWidth: 50,
                            initialValue: _orderQtyValue,
                            minValue: 0,
                            maxValue: widget.item.productQuantity,
                            onChanged: (newValue) =>
                                setState(() => _orderQtyValue = newValue),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addToCart() async {
    cartItem = {"productId": widget.item.id, "quantity": _orderQtyValue};

    cartItemList.add(cartItem);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int token = prefs.getInt(Constants.id);

    if (token != null) {

      Map<String, List> body = {"cartItems": cartItemList};

      var response = ApiCall().addToCart(
        token,
        prefs.getString("token"),
        body,
      );

      response.then((response) {
        print("Api response: $response");

        var statusCode = response['status'];

        if(statusCode < 300) {
          Navigator.pop(context);
          showFlushBar(response['message']);
        } else {
          showFlushBar(response['message']);
        }
      }).catchError((onError) {
          var e = ApiCall().handleRequestError(onError);
        showFlushBar(e);
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
      duration: Duration(
        seconds: 2,
      ),
    )..show(context);
  }
}
