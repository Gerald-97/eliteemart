import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MealCategory {
  final String title;
  final String subtitle;
  final String image;

  MealCategory(
      {@required this.title, @required this.subtitle, @required this.image});

  @override
  String toString() {
    return 'Categories{title: $title, subtitle: $subtitle, image: $image}';
  }
}

class Food {
  final String foodName;
  final String vendor;
  final String image;
  final String vendorImage;
  final String description;
  final String price;

  Food(
      {@required this.foodName,
      @required this.vendor,
      @required this.image,
      @required this.vendorImage,
      @required this.description,
      @required this.price});

  @override
  String toString() {
    return 'Food{food: $foodName, vendor: $vendor, image: $image, vendorImage: $vendorImage, description: $description, price: $price}';
  }

}
