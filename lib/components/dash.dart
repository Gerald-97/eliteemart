import 'package:eliteemart/components/dashboard_categories.dart';
import 'package:eliteemart/components/featured_categories.dart';
import 'package:eliteemart/extras/colors.dart';
import 'package:eliteemart/methods/categories.dart';
import 'package:eliteemart/methods/foods.dart';
import 'package:eliteemart/models/products.dart';
import 'package:eliteemart/pages/meal_categories.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dash extends StatefulWidget {
  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
  List<MealCategory> categories;
  List<Food> food;

  bool _isLoggedIn = false;

  void getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      var token = prefs.getString('token');

      _isLoggedIn = token != null ? true : false;
    });
  }

  @override
  void initState() {
    getInfo();
    List<MealCategory> category = Meal().getCategories();
    categories = (category.take(5).toList()..shuffle());

    List<Food> data = Foods().getFoods();
    food = (data.toList()..shuffle());
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
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: categories.map((categories) {
                  return showCategories(context, categories);
                }).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Featured dishes',
                  style: TextStyle(
                    color: AppColor.onBoardButtonColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: double.infinity,
                height: size.height / 2,
                child: GridView.count(
                  crossAxisCount: 3,
                  children: food.map((food) {
                    return foodDashCard(context, food);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
