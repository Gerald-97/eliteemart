import 'package:eliteemart/models/products.dart';

class Meal {

  List<MealCategory> getCategories() {
    return [
      MealCategory(
        title: 'Breakfast',
        subtitle:
            'By now, you know that breakfast is one of the most important meals of the day. ',
        image: 'images/categories/breakfast_1.jpg',
      ),
      MealCategory(
        title: 'Coffee',
        subtitle:
            'Coffee is a brewed drink prepared from roasted coffee beans, ',
        image: 'images/categories/coffee_1.jpg',
      ),
      MealCategory(
        title: 'Desserts',
        subtitle:
            'When the sweet tooth comes a-knockin\', dish up one these luscious options. ',
        image: 'images/categories/dessert_1.jpg',
      ),
      MealCategory(
        title: 'Dinner',
        subtitle:
            'Dinners exist on a spectrum, from a basic meal, to a state dinner.',
        image: 'images/categories/dinner_1.jpeg',
      ),
      MealCategory(
        title: 'Fruits and Veggies',
        subtitle:
            'A diet rich in vegetables and fruits can lower blood pressure',
        image: 'images/categories/fruits_and_vegetables.jpg',
      ),
      MealCategory(
        title: 'Lunch',
        subtitle:
            'Bored of your daily lunch? Find an exciting new recipe to try',
        image: 'images/categories/lunch_1.jpg',
      ),
      MealCategory(
        title: 'Side Dishes',
        subtitle:
            'Looking for sides that steal the show? We\'ve got you covered:',
        image: 'images/categories/side_dish_1.jpg',
      ),
      MealCategory(
        title: 'Starter',
        subtitle:
            'Kick off your meal in style with our chic selection of starters.',
        image: 'images/categories/starter_1.jpg',
      ),
    ];
  }
}
