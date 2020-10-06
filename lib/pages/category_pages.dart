import 'package:eliteemart/components/featured_categories.dart';
import 'package:eliteemart/methods/api_calls.dart';
import 'package:eliteemart/models/product.dart';
import 'package:eliteemart/models/subcategory.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  final Subcategory category;
  CategoryPage(this.category);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Product products = Product();

  bool _isLoading = true;

  List<ProductElement> productItems = [];
  @override
  void initState() {
    // TODO: implement initState
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black45,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Stack(
            alignment: Alignment.bottomLeft,
            children: <Widget>[
              Text(
                widget.category.subCategoryName,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 1.5
                    ..color = Colors.black87,
                ),
              ),
              Text(
                widget.category.subCategoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 50),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Explore our selection of stuff and place your order',
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              Expanded(
                child: productItems == null
                    ? Center(
                        child: Text(
                          'Nothing to show',
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      )
                    : GridView.count(
                        padding: EdgeInsets.all(0),
                        crossAxisCount: 2,
                        mainAxisSpacing: 3,
                        children: productItems.map((item) {
                          return foodDashCard(context, item);
                        }).toList(),
                      ),
              ),
            ],
          ),
        ));
  }

  void getProducts() {
    var response = ApiCall().getCategoryProducts(widget.category.id);
    response.then((response) {
      setState(() {
        _isLoading = false;
      });
      var statusCode = response['statusCode'];

      if (statusCode >= 300 && statusCode <= 520) {
        print(response['message']);
      } else {
        products = Product.fromJson(response['data']);
        productItems = products.products.toList();
      }
    });
  }
}
