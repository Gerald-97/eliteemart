import 'package:eliteemart/components/dashboard_categories.dart';
import 'package:eliteemart/components/featured_categories.dart';
import 'package:eliteemart/extras/colors.dart';
import 'package:eliteemart/methods/api_calls.dart';
import 'package:eliteemart/models/product.dart';
import 'package:eliteemart/models/subcategory.dart';
import 'package:eliteemart/pages/meal_categories.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Dash extends StatefulWidget {
  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
  List<Subcategory> subCategoryItems = [];
  List<ProductElement> productItems = [];

  Product products;
  SubCategory subCategories = SubCategory();

  bool _isLoading = true;

  void getInfo() async {
    getProducts();
  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Favourites',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllCategories(),
                        ),
                      );
                    },
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: AppColor.onBoardButtonColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: size.height / 5,
              child: _isLoading
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Shimmer.fromColors(
                        period: Duration(
                          milliseconds: 700,
                        ),
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        child: Container(
                          height: size.height / 5.5,
                          child: ListView(
                            padding: EdgeInsets.all(10),
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              Container(
                                width: size.width / 1.5,
                                height: size.height / 5.5,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: size.width / 1.5,
                                height: size.height / 5.5,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : ListView(
                      scrollDirection: Axis.horizontal,
                      children: subCategoryItems.map((items) {
                        return showCategories(context, items);
                      }).toList(),
                    ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Featured products',
                  style: TextStyle(
                    color: AppColor.onBoardButtonColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            _isLoading
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      width: double.infinity,
                      height: size.height / 2,
                      child: GridView.count(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: 3,
                        children: List.generate(
                          12,
                          (index) {
                            return Shimmer.fromColors(
                              period: Duration(
                                milliseconds: 700,
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.grey[100],
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      width: double.infinity,
                      height: size.height / 2,
                      child: GridView.count(
                        crossAxisCount: 3,
                        children: productItems.map((item) {
                          return foodDashCard(context, item);
                        }).toList(),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void getProducts() {
    var response = ApiCall().getAllProducts();
    print('Getting prod');
    response.then((response) {
      var statusCode = response['statusCode'];

      if (statusCode >= 300 && statusCode <= 520) {
        print(response['message']);
        getSubCategories();
      } else {
        getSubCategories();
        products = Product.fromJson(response['data']);
        print('Gotten products');
        productItems = (products.products.toList()..shuffle());
      }
    });
  }

  void getSubCategories() {
    print('Getting cat');
    var response = ApiCall().getAllSubCategories();
    response.then((response) {
      var statusCode = response['status'];

      if (statusCode >= 300 && statusCode <= 520) {
        print(response['message']);
        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        subCategories = SubCategory.fromJson(response['data']);

        for (var items in subCategories.subcategories) {
          subCategoryItems.add(items);
          subCategoryItems = (subCategoryItems.take(5).toList()..shuffle());
        }
      }
    }).catchError((onError) {
      setState(() {
        _isLoading = false;
      });
      showFlushBar(ApiCall().handleRequestError(onError));
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
