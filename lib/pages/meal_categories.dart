import 'package:eliteemart/extras/colors.dart';
import 'package:eliteemart/methods/api_calls.dart';
import 'package:eliteemart/models/subcategory.dart';
import 'package:eliteemart/pages/category_pages.dart';
import 'package:flutter/material.dart';

class AllCategories extends StatefulWidget {
  @override
  _AllCategoriesState createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  List<Subcategory> subCategoryItems = [];

  SubCategory subCategories = SubCategory();

  bool _isLoading = true;

  void initState() {
    getSubCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'All Categories',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColor.onBoardButtonColor,
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  children: subCategoryItems.map((categories) {
                    return viewCategories(context, categories);
                  }).toList()),
            ),
          ],
        ),
      ),
    );
  }

  Widget viewCategories(BuildContext context, Subcategory categories) {
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
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: _isLoading ? CircularProgressIndicator() : Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Text(
                    categories.subCategoryName,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = Colors.black87,
                    ),
                  ),
                  Text(
                    categories.subCategoryName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
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

  void getSubCategories() {
    var response = ApiCall().getAllSubCategories();
    response.then((response) {

      setState(() {
        _isLoading = false;
      });
      var statusCode = response['status'];

      print(statusCode);

      if (statusCode >= 300 && statusCode <= 520) {
        print(response['message']);
      } else {
        subCategories = SubCategory.fromJson(response['data']);
        for (var items in subCategories.subcategories) {
          subCategoryItems.add(items);
        }
      }
    });
  }
}
