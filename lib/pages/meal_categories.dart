import 'package:eliteemart/extras/colors.dart';
import 'package:eliteemart/methods/categories.dart';
import 'package:eliteemart/models/products.dart';
import 'package:eliteemart/pages/category_pages.dart';
import 'package:flutter/material.dart';

class AllCategories extends StatefulWidget {
  @override
  _AllCategoriesState createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  List<MealCategory> categories;
  void initState() {
    categories = Meal().getCategories();
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
                  children: categories.map((categories) {
                    return viewCategories(context, categories);
                  }).toList()),
            ),
          ],
        ),
      ),
    );
  }

  Widget viewCategories(BuildContext context, MealCategory categories) {
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
          image: DecorationImage(
            image: AssetImage(
              categories.image,
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              AppColor.onBoardButtonColorLight.withOpacity(0.2),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Text(
                    categories.title,
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
                    categories.title,
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
}
