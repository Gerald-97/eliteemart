import 'package:eliteemart/extras/colors.dart';
import 'package:eliteemart/extras/constants.dart';
import 'package:eliteemart/methods/api_calls.dart';
import 'package:eliteemart/models/cart.dart';
import 'package:eliteemart/models/cart_get_model.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<List<String>> cartList = [];
  List<CartGet> cartGet = [];

  bool _isLoading = true;

  @override
  void initState() {
    getCart();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: BackButton(
          color: Colors.black45,
        ),
        title: Text(
          'Your Cart',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: AppColor.onBoardButtonColor,
              size: 30,
            ),
            splashColor: AppColor.onBoardButtonColorLight,
            onPressed: () {},
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColor.onBoardButtonColorLight,
              ),
            )
          : cartGet == null
              ? Center(
                  child: Text(
                    'Nothing in Cart',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black45,
                    ),
                  ),
                )
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: cartGet.map((item) {
                    return cartItem(context, item);
                  }).toList(),
                ),
    );
  }

  Widget cartItem(BuildContext context, CartGet item) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Image.network(
                    item.productAvatar,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      item.productName,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      item.productPrice,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Price',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      item.totalCost,
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColor.onBoardButtonColorLight,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: IconButton(
                    onPressed: () {
//                      removeItem(item);
                    },
                    icon: Icon(
                      Icons.restore_from_trash,
                      color: AppColor.onBoardButtonColorLight,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }

  void getCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt(Constants.id);
    String token = prefs.getString('token');

    if (token != null) {
      var response = ApiCall().getUserCart(id, token);
      response.then((response) {
        setState(() {
          _isLoading = false;
        });
        var responseCode = response['status'];

        if (responseCode < 300) {
          print(response['data']);
          for (var item in response['data']) {
            cartGet.add(CartGet.fromJson(item));
            print(item);
          }
          print(cartGet.toString());
        } else {
          showFlushBar(response['message']);
        }
      }).catchError((onError) {
        print(onError);
        setState(() {
          _isLoading = false;
        });
        showFlushBar(ApiCall().handleRequestError(onError));
      });
    }
  }

  void removeItem(List item) {
    setState(() {
      cartList.removeAt(cartList.indexOf(item));
    });
  }

  void showFlushBar(String message) {
    Flushbar(
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.black87,
        ),
      ),
      borderColor: AppColor.onBoardButtonColorLight,
      backgroundColor: Colors.white70,
      duration: Duration(seconds: 3),
    )..show(context);
  }
}
