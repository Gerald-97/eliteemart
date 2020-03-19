import 'package:eliteemart/components/featured_categories.dart';
import 'package:eliteemart/methods/foods.dart';
import 'package:eliteemart/models/products.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  final MealCategory category;
  CategoryPage(this.category);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Food> food;
  @override
  void initState() {
    // TODO: implement initState
    List<Food> data = Foods().getFoods();
    food = (data.toList()..shuffle());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height / 4.5),
          child: AppBar(
            flexibleSpace: Image(
              image: AssetImage(widget.category.image),
              fit: BoxFit.cover,
              color: Colors.black54.withOpacity(0.3),
              colorBlendMode: BlendMode.lighten,
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Stack(
              alignment: Alignment.bottomLeft,
              children: <Widget>[
                Text(
                  widget.category.title,
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
                  widget.category.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
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
                  'Explore our selection of meals and place your order',
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              Expanded(
                child: GridView.count(
                  padding: EdgeInsets.all(0),
                  crossAxisCount: 2,
                  mainAxisSpacing: 3,
                  children: food.map((food) {
                    return foodDashCard(context, food);
                  }).toList(),
                ),
              ),
            ],
          ),
        ));
  }
}
